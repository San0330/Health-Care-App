import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/home_cubit/home_cubit.dart';
import '../../../appointment_lists_page/appointment_list.dart';

class Appointments extends StatelessWidget {
  const Appointments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (ctx, state) {
          if (state is HomeLoaded) {
            final int appointmentCount = state.homeModel.appointmentCount;
            String message = "Your appointments.";

            if (appointmentCount > 0) {
              message = "You have $appointmentCount appointment";
            } else {
              message = "You have no appointment";
            }

            return Stack(
              children: [
                Container(
                  height: 56,
                  width: 4,
                  color: Theme.of(context).primaryColor,
                ),
                ListTile(
                  title: Text(
                    message,
                    style: TextStyle(
                      color: Theme.of(ctx).primaryColor,
                      fontSize: 16.0,
                    ),
                  ),
                  trailing: RaisedButton(
                    onPressed: appointmentCount == 0
                        ? null
                        : () {
                            Navigator.pushNamed(
                              ctx,
                              AppointmentList.routeName,
                            );
                          },
                    color: Theme.of(ctx).primaryColor,
                    child: const Text(
                      "View",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
