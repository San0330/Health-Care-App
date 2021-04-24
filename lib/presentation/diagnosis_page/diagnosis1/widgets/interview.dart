import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/diagnosis_cubit/diagnosis_cubit.dart';
import '../../../../domain/diagnosis/conditions.dart';
import '../../../../domain/diagnosis/diagnosis.dart';

class Interview extends StatefulWidget {
  const Interview();

  @override
  _InterviewState createState() => _InterviewState();
}

class _InterviewState extends State<Interview> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosisCubit, DiagnosisCubitState>(
      builder: (context, state) {
        final interviewState = state as DiagnosisInterviewState;
        final diagnosis = interviewState.diagnosis;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Interview"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (!diagnosis.shouldStop) ...[
                  buildQuestionContainer(diagnosis.question),
                  buildAnswerChoices(diagnosis.question.items[0]),
                ],
                const SizedBox(height: 10),
                const Text(
                  "Summary",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                const SizedBox(height: 10),
                buildConditionsInfo(diagnosis.conditions),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildConditionsInfo(List<Conditions> conditions) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: conditions
              .map(
                (Conditions c) => Row(
                  children: [
                    Expanded(
                      child: Text(
                        c.commonName,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text("${(c.probability * 100).toStringAsFixed(2)} %"),
                  ],
                ),
              )
              .toList(),
        ),
      );

  Row buildAnswerChoices(Items item) {
    final List<Choices> choices = item.choices;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: choices
          .map(
            (Choices choice) => RaisedButton(
              color: choice.label == 'Yes'
                  ? Colors.blue
                  : choice.label == 'No'
                      ? Colors.red
                      : Colors.purple,
              onPressed: () {
                context.read<DiagnosisCubit>().yesNoBtnPressed(
                      c: Condition(
                        id: item.id,
                        name: item.name,
                        choiceid: choice.id,
                      ),
                    );
              },
              child: Text(
                choice.label,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Container buildQuestionContainer(Question question) => Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          question.text,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.grey,
          ),
        ),
      );
}
