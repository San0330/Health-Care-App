import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/doctors_cubit/doctors_cubit.dart';
import '../../injection.dart';
import 'widgets/doctors_grid.dart';

class DoctorsList extends StatelessWidget {
  static String routeName = '/doctors-list-page';

  const DoctorsList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DoctorsCubit>()..load(),
      child: MyDoctorsList(),
    );
  }
}

class MyDoctorsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Appoint Doctor"),
        ),
        body: BlocBuilder<DoctorsCubit, DoctorsState>(
          builder: (context, state) {
            if (state is DoctorsInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DoctorsLoadingFailed) {
              return const Center(
                child: Text("Failed to load data"),
              );
            } else {
              final doctors = (state as DoctorsLoaded).doctors;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 0.2,
                  crossAxisSpacing: 0.2,
                ),
                itemBuilder: (context, index) => DoctorsGrid(
                  doctor: doctors.doctors[index],
                ),
                itemCount: doctors.doctors.length,
              );
            }
          },
        ),
      ),
    );
  }
}
