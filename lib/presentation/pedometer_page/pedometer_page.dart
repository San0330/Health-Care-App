import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sensors/sensors.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'bar_chart.dart';

enum PedometerState {
  running,
  paused,
}

class PedometerPage extends StatefulWidget {
  static String routeName = 'pedometer-page';

  const PedometerPage();

  @override
  _PedometerPageState createState() => _PedometerPageState();
}

class _PedometerPageState extends State<PedometerPage> {
  StreamSubscription<AccelerometerEvent> subscription;

  List<double> accNorm = [];

  int steps = 0;
  int totalSteps = 0;
  int minuteCount = 0;
  Timer t;

  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String month = DateFormat('MMMM').format(DateTime.now());

  PedometerState ps = PedometerState.paused;

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  static int getStepCounts(List<double> a) {
    final int n = a.length;
    final Map<int, double> distances = {};

    for (int i = 1; i < n - 1; i++) {
      if (a[i] > a[i - 1] && a[i] > a[i + 1]) {
        distances[i] = a[i];
      }
    }

    // all the peaks below value 12 is removed
    final List<int> toremove = [];
    for (final int key in distances.keys) {
      final double val = distances[key];

      if (val < 12) {
        toremove.add(key);
      }
    }

    for (final int idx in toremove) {
      distances.remove(idx);
    }

    if (distances.isEmpty) return 0;

    final double sum = distances.values.fold(0, (p, c) => p + c);
    final double avg = sum / distances.length;

    int step = 0;
    for (final double value in distances.values) {
      final double max = math.max(avg, value);
      final double min = math.min(avg, value);
      if (max - min <= 3) {
        step++;
      }
    }

    return step;
  }

  void pauseCount() {
    subscription.cancel();
    setState(() {
      ps = PedometerState.paused;
    });
    pauseTimer();
  }

  void resumeCount() {
    setState(() {
      ps = PedometerState.running;
    });

    runTimer();

    subscription = accelerometerEvents.listen((AccelerometerEvent event) {
      final double norm = math.sqrt(
        math.pow(event.x, 2) + math.pow(event.y, 2) + math.pow(event.z, 2),
      );

      accNorm.add(norm);

      if (accNorm.length >= 15) {
        steps = getStepCounts(accNorm);
        accNorm.clear();

        setState(() {
          totalSteps += steps;
        });
      }
    });
  }

  void runTimer() {
    t = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        minuteCount++;
      });
    });
  }

  void pauseTimer() {
    t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomPaint(
              size: const Size(316, 200),
              painter: RPSCustomPainter(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              month,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              today,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white38,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 230,
                    child: CircularPercentIndicator(
                        radius: 150,
                        lineWidth: 13.0,
                        percent: totalSteps / 500,
                        animation: true,
                        center: Text(
                          "$totalSteps steps",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        progressColor: Colors.blue,
                        backgroundColor: Colors.white30),
                  ),
                  InkWell(
                    onTap:
                        ps == PedometerState.running ? pauseCount : resumeCount,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ps == PedometerState.running
                            ? Colors.green
                            : Colors.red,
                      ),
                      child: Icon(
                        ps == PedometerState.running
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.timelapse,
                        size: 30,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "$minuteCount min",
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department_outlined,
                        size: 30,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${(totalSteps * 0.033).toStringAsFixed(3)} cal",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(),
            const Text("Daily count by percent"),
            SizedBox(
              height: 160,
              child: SimpleBarChart.withSampleData(),
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint_0 = Paint()
      ..color = const Color.fromARGB(155, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    final Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.quadraticBezierTo(0, size.height * 0.60, 0, size.height * 0.80);
    path_0.quadraticBezierTo(
        size.width * 0.09, size.height * 0.95, size.width * 0.38, size.height);
    path_0.quadraticBezierTo(size.width * 0.32, size.height * 0.81,
        size.width * 0.51, size.height * 0.80);
    path_0.quadraticBezierTo(
        size.width * 0.66, size.height * 0.81, size.width * 0.63, size.height);
    path_0.quadraticBezierTo(
        size.width * 0.91, size.height * 0.97, size.width, size.height * 0.80);
    path_0.quadraticBezierTo(size.width, size.height * 0.60, size.width, 0);
    path_0.lineTo(0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
