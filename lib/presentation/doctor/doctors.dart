import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/appointment_actions_cubit/appointment_action_cubit.dart';
import '../../infrastructure/core/api_constants.dart';
import '../../injection.dart';
import '../home_page/widgets/widgets.dart';

class DoctorsAppointments extends StatelessWidget {
  static String routeName = 'doctors-appointment';

  const DoctorsAppointments();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentActionCubit>(
      create: (context) =>
          getIt<AppointmentActionCubit>()..fetchDocAppointment(),
      child: SafeArea(
        child: Scaffold(
          drawer: const AppDrawer(),
          appBar: AppBar(
            title: const Text("Appointments"),
          ),
          body: BlocBuilder<AppointmentActionCubit, AppointmentActionState>(
              builder: (context, state) {
            if (state is! AppointmentFetched) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const DocAppointmentLists();
          }),
        ),
      ),
    );
  }
}

class DocAppointmentLists extends StatelessWidget {
  const DocAppointmentLists({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppointmentActionCubit>().state;
    final appointmentState = state as AppointmentFetched;

    return Container(
      padding: const EdgeInsets.all(5),
      child: ListView.separated(
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final user = appointmentState.appointments.appointments[index].user;
          final appointments =
              appointmentState.appointments.appointments[index];

          return Column(
            children: [
              ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  radius: 35,
                  backgroundImage: CachedNetworkImageProvider(
                    ApiConstants.imageUrl(user.image),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name),
                    Text(
                      "Date: ${appointments.date}, TimeRange: ${appointments.timerange[0].start}-${appointments.timerange[0].end}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                subtitle: Text(
                  appointments.problem,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              Center(
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {},
                  child: const Text(
                    "View details",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        },
        itemCount: appointmentState.appointments.appointments.length,
      ),
    );
  }
}
