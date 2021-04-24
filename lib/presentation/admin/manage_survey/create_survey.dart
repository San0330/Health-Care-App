import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/survey_cud_cubit/survey_cud_cubit.dart';
import '../../../domain/survey/questions.dart';
import '../../../domain/survey/survey.dart';

class CreateSurvey extends StatefulWidget {
  const CreateSurvey();

  @override
  _CreateSurveyState createState() => _CreateSurveyState();
}

class _CreateSurveyState extends State<CreateSurvey> {
  Survey s = Survey(
    title: "",
    questions: [],
  );

  List<List<TextEditingController>> controller = [];

  @override
  void initState() {
    super.initState();
    s.questions.add(
      Question(
        question: "",
        options: [''],
      ),
    );

    controller.add([
      TextEditingController(text: ''),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    for (final ctrller in controller) {
      for (final ctrl in ctrller) {
        ctrl.dispose();
      }
    }
  }

  void addquestion() {
    setState(() {
      s.questions.add(
        Question(
          question: "",
          options: [''],
        ),
      );

      controller.add([
        TextEditingController(text: ''),
      ]);
    });
  }

  void submit(BuildContext context) {
    String msg = '';
    if (s.title.isEmpty) {
      msg = "Title Invalid";
    } else if (s.questions.isEmpty) {
      msg = "Enter some questions";
    } else {
      for (final Question q in s.questions) {
        if (q.options.isEmpty || q.question.isEmpty) {
          msg = "Improper data";
        }
      }
    }

    if (msg.isNotEmpty) {
      FlushbarHelper.createError(message: msg).show(context);
      return;
    }

    context.read<SurveyCudCubit>().createSurvey(s.toJson());
    FlushbarHelper.createSuccess(
            message: "Surver successfully created",
            duration: const Duration(seconds: 1))
        .show(context)
        .then(
          (_) => Navigator.pop(context),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Survey"),
      ),
      body: BlocListener<SurveyCudCubit, SurveyCUDCubitState>(
        listener: (context, state) {
          state.failure.fold(
            () => Navigator.pop(context),
            (a) => FlushbarHelper.createError(message: a.message).show(context),
          );
        },
        child: Form(
          child: ListView.separated(
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              if (index == s.questions.length) {
                return AddNewQuestionBtn(addquestion, submit);
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (index == 0) ...[
                      TextField(
                        onChanged: (value) {
                          s.title = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Add Survey Title',
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    TextField(
                      onChanged: (value) {
                        s.questions[index] = Question(
                          question: value,
                          options: s.questions[index].options,
                        );
                      },
                      decoration: const InputDecoration(
                        hintText: 'Add your question',
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, idx) {
                        final optionsTextField = SizedBox(
                          width: 280,
                          child: TextFormField(
                            controller: controller[index][idx],
                            decoration: const InputDecoration(
                              hintText: 'Add an option',
                            ),
                            onChanged: (value) {
                              s.questions[index].options[idx] = value;
                              // controller[index][idx].selection =
                              //     TextSelection.fromPosition(TextPosition(
                              //   offset: value.length,
                              // ));
                            },
                          ),
                        );

                        if (idx == s.questions[index].options.length - 1) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                optionsTextField,
                                IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      s.questions[index].options.add('');

                                      controller[index].add(
                                        TextEditingController(text: ''),
                                      );
                                    });
                                  },
                                )
                              ],
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              optionsTextField,
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    controller[index].removeAt(idx);

                                    s.questions[index].options.removeAt(idx);
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: s.questions[index].options.length,
                    ),
                  ],
                ),
              );
            },
            itemCount: s.questions.length + 1,
          ),
        ),
      ),
    );
  }
}

class AddNewQuestionBtn extends StatelessWidget {
  final Function addNewQuestion;
  final Function submit;

  const AddNewQuestionBtn(this.addNewQuestion, this.submit);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RaisedButton.icon(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          color: Colors.blue,
          onPressed: () => addNewQuestion(),
          label: const Text(
            "Add question",
            style: TextStyle(color: Colors.white),
          ),
        ),
        RaisedButton.icon(
          icon: const Icon(
            Icons.done,
            color: Colors.white,
          ),
          color: Colors.green,
          onPressed: () => submit(context),
          label: const Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
