import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/survey_cubit/survey_cubit.dart';
import '../../domain/survey/survey.dart';
import 'survey.dart';

class SurveysPage extends StatelessWidget {
  static String routeName = 'surveys-page';

  const SurveysPage();

  @override
  Widget build(BuildContext context) {
    return const MySurveysPage();
  }
}

class MySurveysPage extends StatefulWidget {
  const MySurveysPage();

  @override
  _MySurveysPageState createState() => _MySurveysPageState();
}

class _MySurveysPageState extends State<MySurveysPage> {
  @override
  void initState() {
    super.initState();
    context.read<SurveyCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Surveys"),
          ),
          body: BlocBuilder<SurveyCubit, SurveycubitState>(
            builder: (context, state) {
              if (state is SurveycubitLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SurveycubitLoaded) {
                final List<Survey> surveys = state.surveys;

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(surveys[index].title),
                        subtitle: Text(
                            "${surveys[index].questions.length} questions"),
                        trailing: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SurveyPage(index),
                              ),
                            );
                          },
                          color: Colors.blue,
                          child: const Text(
                            "Take Survey",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: surveys.length,
                );
              } else {
                return const Center(child: Text("Failed"));
              }
            },
          )),
    );
  }
}
