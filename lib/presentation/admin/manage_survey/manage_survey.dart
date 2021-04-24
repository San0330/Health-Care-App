import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/survey_cubit/survey_cubit.dart';
import '../../../domain/survey/survey.dart';
import '../widgets/animated_fab.dart';
import 'create_survey.dart';
import 'survey_results.dart';

class ManageSurvey extends StatefulWidget {
  static String routeName = 'Manage-Survey';

  const ManageSurvey();

  @override
  _ManageSurveyState createState() => _ManageSurveyState();
}

class _ManageSurveyState extends State<ManageSurvey> {
  @override
  void initState() {
    super.initState();
    context.read<SurveyCubit>()..loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Surveys"),
      ),
      floatingActionButton: const AnimatedFloatingBtn(toshow: CreateSurvey()),
      body: Builder(
        builder: (context) {
          final state = context.watch<SurveyCubit>().state;

          if (state is SurveycubitLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SurveycubitLoaded) {
            final List<Survey> surveys = state.surveys;

            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(surveys[index].title),
                    subtitle:
                        Text("${surveys[index].questions.length} questions"),
                    trailing: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          SurveyResultsPage.routeName,
                          arguments: surveys[index].id,
                        );
                      },
                      color: Colors.blue,
                      child: const Text(
                        "Survey Details",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
              itemCount: surveys.length,
            );
          } else if (state is SurveycubitFailed) {
            return Center(child: Text(state.failure.message));
          } else {
            return const Center(child: Text("Unknown state"));
          }
        },
      ),
    );
  }
}
