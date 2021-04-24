import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/diagnosis_cubit/diagnosis_cubit.dart';
import '../../../domain/diagnosis/conditions.dart';
import '../../../injection.dart';
import 'widgets/widgets.dart';

class Diagnosis1 extends StatelessWidget {
  static String routeName = '/diagnosis-1';

  const Diagnosis1();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DiagnosisCubit>(),
      child: BlocBuilder<DiagnosisCubit, DiagnosisCubitState>(
        builder: (context, state) {
          if (state is DiagnosisSearchState) {
            return MyDiagnosis1();
          } else if (state is DiagnosisInterviewState) {
            return const Interview();
          } else if (state is DiagnosisLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text("Failed"),
              ),
            );
          }
        },
      ),
    );
  }
}

class MyDiagnosis1 extends StatefulWidget {
  @override
  _MyDiagnosis1State createState() => _MyDiagnosis1State();
}

class _MyDiagnosis1State extends State<MyDiagnosis1> {
  StreamController<String> controller = StreamController();
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    controller.close();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diagnosis 1"),
      ),
      body: BlocBuilder<DiagnosisCubit, DiagnosisCubitState>(
        builder: (context, state) {
          final searchState = state as DiagnosisSearchState;
          final List<Condition> conditions = searchState.conditions;

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: "Search your symptoms",
                    ),
                    onChanged: (val) => controller.sink.add(val),
                  ),
                  StreamBuilder<String>(
                    stream: controller.stream,
                    initialData: '',
                    builder: (context, snapshot) {
                      if (snapshot.data.isNotEmpty) {
                        return Column(
                          children: conditions
                              .where(
                                (element) =>
                                    element.name
                                        .toLowerCase()
                                        .contains(snapshot.data) &&
                                    !context
                                        .watch<DiagnosisCubit>()
                                        .hasAlready(element),
                              )
                              .take(10)
                              .map(
                                (e) => ListTile(
                                  title: Text(e.name),
                                  onTap: () {
                                    context
                                        .read<DiagnosisCubit>()
                                        .addSymptom(e);
                                    controller.add('');
                                    textEditingController.clear();
                                  },
                                ),
                              )
                              .toList(),
                        );
                      } else {
                        if (searchState.selectedConditions.isEmpty) {
                          return const InfoMessage();
                        } else {
                          return const SelectedConditionsChips();
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
