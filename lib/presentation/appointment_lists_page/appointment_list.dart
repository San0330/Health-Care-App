import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../application/appointment_actions_cubit/appointment_action_cubit.dart';
import '../../application/home_cubit/home_cubit.dart';
import '../../infrastructure/core/api_constants.dart';

class AppointmentList extends StatelessWidget {
  static String routeName = '/appointment-page';

  const AppointmentList();

  @override
  Widget build(BuildContext context) {
    context.read<AppointmentActionCubit>().fetchAppointment();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Appointments"),
        ),
        body: BlocConsumer<AppointmentActionCubit, AppointmentActionState>(
          listener: (context, state) {
            if (state is AppointmentActionDeleted) {
              context.read<HomeCubit>().reduceAppointmentCount();
              FlushbarHelper.createSuccess(
                message: "Appointment deleted",
                duration: const Duration(seconds: 2),
              ).show(context).then(
                    (_) => Navigator.pop(context),
                  );
            }
          },
          builder: (context, state) {
            if (state is! AppointmentFetched) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final appointmentState = state as AppointmentFetched;

            return ListView.separated(
              separatorBuilder: (context, idx) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                height: 2,
                color: Colors.grey.withOpacity(0.5),
              ),
              itemBuilder: (context, idx) {
                final name =
                    appointmentState.appointments.appointments[idx].doctor.name;
                final field = appointmentState
                    .appointments.appointments[idx].doctor.field;
                final image = appointmentState
                    .appointments.appointments[idx].doctor.image;
                final date =
                    appointmentState.appointments.appointments[idx].date;
                final timerange = appointmentState
                    .appointments.appointments[idx].timerange[0];

                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundImage: CachedNetworkImageProvider(
                            ApiConstants.imageUrl(image),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              field,
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date : ${DateFormat.yMMMd().format(
                                DateTime.parse(date),
                              )}",
                            ),
                            Text(
                              "Time : ${timerange.start} - ${timerange.end}",
                            ),
                          ],
                        ),
                      ),
                      AppointmentControlButtons(
                        appointmentState.appointments.appointments[idx].id,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
              itemCount: appointmentState.appointments.appointments.length,
            );
          },
        ),
      ),
    );
  }
}

class AppointmentControlButtons extends StatelessWidget {
  final String appointmentId;

  const AppointmentControlButtons(this.appointmentId);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            FlushbarHelper.createInformation(message: "Not implemented")
                .show(context);
          },
          color: Colors.blueAccent,
          child: const Text(
            "Reschedule",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            context
                .read<AppointmentActionCubit>()
                .deleteAppointment(appointmentId);
          },
          color: Colors.redAccent,
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
