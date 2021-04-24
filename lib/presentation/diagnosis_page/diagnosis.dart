import 'package:flutter/material.dart';

import '../../utils/contextx.dart';
import 'diagnosis1/diagnosis1.dart';

class DiagnosisScreen extends StatelessWidget {
  static String routeName = './diagnosis-screen';

  const DiagnosisScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Diagnosis",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 0.5 * context.screenWidth,
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Diagnosis1.routeName),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.8),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "D1",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Diagnosis 1",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // const SizedBox(width: 5),
                // Expanded(
                //   child: InkWell(
                //     onTap: () {},
                //     child: Container(
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.blue.withOpacity(0.8)),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       padding: const EdgeInsets.all(10),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: const [
                //           Text(
                //             "D2",
                //             style: TextStyle(
                //               fontSize: 30,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.blue,
                //             ),
                //           ),
                //           SizedBox(height: 20),
                //           Text(
                //             "Diagnosis 2",
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.warning,
                      size: 40,
                      color: Colors.red,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "CAUTION !!! THIS IS AN EXPERIMENTAL FEATURE, PLEASE DON'T FORGET TO GET ADVISE FROM YOUR DOCTOR",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
