import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/survey_result_cubit/survey_result_cubit.dart';
import '../../../domain/survey/answer_count.dart';
import '../../../injection.dart';

class SurveyResultsPage extends StatelessWidget {
  static String routeName = './survey-results-page';

  const SurveyResultsPage();

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;

    return BlocProvider(
      create: (context) => getIt<SurveyResultCubit>()..loadData(id),
      child: const MySurveyResultsPage(),
    );
  }
}

class MySurveyResultsPage extends StatelessWidget {
  const MySurveyResultsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Survey Result"),
      ),
      body: BlocBuilder<SurveyResultCubit, SurveyResultState>(
        builder: (context, state) {
          if (state is SurveyResultError) {
            return const Center(
              child: Text("ERROR !"),
            );
          } else if (state is SurveyResultLoaded) {
            return ListView.builder(
              itemBuilder: (context, idx) {
                return ResultData(
                  question: state.surveyResult[idx].question,
                  answers: state.surveyResult[idx].answerCounts,
                );
              },
              itemCount: state.surveyResult.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ResultData extends StatelessWidget {
  const ResultData({Key key, this.question, this.answers}) : super(key: key);

  final String question;
  final List<AnswerCount> answers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.grey,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 150,
            width: double.infinity,
            child: charts.PieChart(
              [
                charts.Series<AnswerCount, String>(
                  id: 'samples',
                  measureFn: (AnswerCount answerCount, _) => answerCount.count,
                  domainFn: (AnswerCount answerCount, _) => answerCount.answer,
                  labelAccessorFn: (AnswerCount answerCount, _) =>
                      "${answerCount.answer} : ${answerCount.count}",
                  data: answers,
                ),
              ],
              defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [
                charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.outside,
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
