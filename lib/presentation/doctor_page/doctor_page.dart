import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../application/home_cubit/home_cubit.dart';

import '../../application/appointment_actions_cubit/appointment_action_cubit.dart';
import '../../domain/doctors/doctor.dart';
import '../../infrastructure/core/api_constants.dart';
import 'widgets/appointment_form.dart';

class DoctorPage extends StatelessWidget {
  static String routeName = '/doctor-page';

  const DoctorPage();    

  static const List<String> days = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thur",
    "Fri",
    "Sat"
  ];

  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context).settings.arguments as Doctor;

    return BlocListener<AppointmentActionCubit, AppointmentActionState>(
      listener: (context, state) {
        if (state is AppointmentActionCreated) {
          context.read<HomeCubit>().addAppointmentCount();
          FlushbarHelper.createSuccess(
            message: "Appointment created",
            duration: const Duration(seconds: 2),
          ).show(context).then((_) => Navigator.pop(context));
        } else if (state is AppointmentActionFailed) {
          FlushbarHelper.createError(
            message: "Unable to create appointment",
            duration: const Duration(seconds: 2),
          ).show(context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text(doctor.name)),
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.black12),
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 400,
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 10.0,
                    top: 30.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 20,
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      ApiConstants.imageUrl(doctor.image),
                    ),
                    radius: 45.0,
                  ),
                ),
                Positioned(
                  top: 35,
                  left: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          height: 28,
                          child: FittedBox(
                            alignment: Alignment.topLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              doctor.name,
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          doctor.field ?? "Pharmacist",
                          style: const TextStyle(
                            letterSpacing: 1.2,
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          width: 300,
                          child: Text(
                            '${doctor.name} is the most renkown doctor in the field of everything, so far he has 5 years of experience He is a good doctor and everyone know him as a good doctor',
                            style: const TextStyle(
                              letterSpacing: 1.2,
                              fontSize: 15.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Working weeks",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          width: 300,
                          child: Wrap(
                            spacing: 4.0,
                            children: days
                                .map((day) => Chip(
                                      backgroundColor: Colors.transparent,
                                      label: Text(day),
                                      labelStyle: TextStyle(
                                        color: doctor.workingWeeks
                                                .contains(days.indexOf(day) + 1)
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        const Text(
                          "Working hours",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          width: 300,
                          child: Wrap(
                            children: doctor.workingHours
                                .map((x) => SizedBox(
                                      width: 150,
                                      child: Text(
                                        "${x.start} - ${x.end}",
                                        style: const TextStyle(fontSize: 15.0),
                                        textAlign: TextAlign.left,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.blue,
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AppointmentForm(
                doctorId: doctor.id,
                workingHours: doctor.workingHours,
              ),
            ),
            icon: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                FontAwesomeIcons.notesMedical,
                color: Colors.white,
              ),
            ),
            label: const Text(
              "Appoint",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
