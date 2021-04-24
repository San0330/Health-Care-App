import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/survey_cubit/survey_cubit.dart';
import '../../application/survey_cud_cubit/survey_cud_cubit.dart';
import '../../domain/survey/survey.dart';

class SurveyPage extends StatefulWidget {
  static String routeName = 'survey-page';
  final int index;

  const SurveyPage(this.index);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  // pair of question and selection option
  final Map<String, String> selectedOptions = {};

  Survey survey;
  SurveycubitLoaded state;

  @override
  void initState() {
    super.initState();
    state = context.read<SurveyCubit>().state as SurveycubitLoaded;

    survey = state.surveys[widget.index];

    for (final element in survey.questions) {
      selectedOptions[element.question] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SurveyCudCubit, SurveyCUDCubitState>(
      listener: (context, state) {
        state.failure.fold(
          () => FlushbarHelper.createSuccess(
            message: "Success",
            duration: const Duration(seconds: 1),
          ).show(context).then(
                (_) => Navigator.pop(context),
              ),
          (f) => FlushbarHelper.createError(
            message: "Invalid",
            duration: const Duration(seconds: 1),
          ).show(context).then(
                (_) => Navigator.pop(context),
              ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(survey.title),
        ),
        body: Scrollbar(
          child: ListView.separated(
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              if (index == survey.questions.length) {
                return Center(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      final List<Map<String, String>> selectedOptionsList = [];

                      for (final key in selectedOptions.keys) {
                        if (selectedOptions[key] == null) {
                          FlushbarHelper.createError(
                            message: "Fill all options",
                          ).show(context);

                          return;
                        }

                        selectedOptionsList.add({
                          'question': key,
                          'answer': selectedOptions[key],
                        });
                      }

                      context
                          .read<SurveyCudCubit>()
                          .submitSurvey(
                            survey.id,
                            selectedOptionsList,
                          )
                          .then((_) => Navigator.pop(context));
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      survey.questions[index].question,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    for (String option in survey.questions[index].options)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RadioListTile<String>(
                          title: Text(option),
                          value: option,
                          groupValue:
                              selectedOptions[survey.questions[index].question],
                          onChanged: (value) {
                            setState(() {
                              selectedOptions[
                                  survey.questions[index].question] = value;
                            });
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
            itemCount: survey.questions.length + 1,
          ),
        ),
      ),
    );
  }
}
