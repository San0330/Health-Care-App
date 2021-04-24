import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/appointment_actions_cubit/appointment_action_cubit.dart';
import '../../../domain/doctors/working_hours.dart';

class AppointmentForm extends StatelessWidget {
  final String doctorId;
  final List<WorkingHours> workingHours;

  const AppointmentForm({
    Key key,
    this.doctorId,
    this.workingHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAppointmentForm(
      doctorId: doctorId,
      workingHours: workingHours,
    );
  }
}

class MyAppointmentForm extends StatefulWidget {
  final String doctorId;
  final List<WorkingHours> workingHours;

  const MyAppointmentForm({
    Key key,
    this.doctorId,
    this.workingHours,
  }) : super(key: key);

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<MyAppointmentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _problemController = TextEditingController();
  final _contactController = TextEditingController();

  final Map<String, dynamic> data = {
    "doctorid": "",
    'problem': "",
    'contacts': "",
    'date':
        "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
    'workingHours': null,
  };

  Widget createForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildProblemTextField(),
            _buildContactTextField(),
            _buildDateField(),
            _changeDate(),
            const Divider(),
            const Text("Select time:"),
            _buildTimeRangeSelector(),
          ],
        ),
      ),
    );
  }

  Wrap _buildTimeRangeSelector() {
    return Wrap(
      children: widget.workingHours
          .map((e) => Row(
                children: [
                  Radio<WorkingHours>(
                    groupValue: data['workingHours'] as WorkingHours,
                    value: e,
                    onChanged: (value) {
                      setState(() {
                        data['workingHours'] = value;
                      });
                    },
                  ),
                  Text("${e.start} - ${e.end}"),
                ],
              ))
          .toList(),
    );
  }

  Widget _buildDateField() {
    return Container(
      margin: const EdgeInsets.only(top: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('Date:'),
          Text(data['date'] as String),
        ],
      ),
    );
  }

  Widget _changeDate() {
    return OutlineButton(
      onPressed: () async {
        final getDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2022),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.dark(),
              child: child,
            );
          },
        );

        if (getDate != null) {
          setState(() {
            data['date'] = "${getDate.year}/${getDate.month}/${getDate.day}";
          });
        }
      },
      child: const Text("Change Date"),
    );
  }

  Widget _buildProblemTextField() {
    if (_problemController.text.trim() != '') {
      _problemController.text = _problemController.text.trim();
    }
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Problem'),
      controller: _problemController,
      keyboardType: TextInputType.multiline,
      maxLength: 250,
      validator: (String value) {
        if (value.trim().isEmpty) return "Can't be empty !!!";
        return null;
      },
      onSaved: (String value) {
        data['problem'] = value;
      },
    );
  }

  Widget _buildContactTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Contact No.'),
      controller: _contactController,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.trim().isEmpty) return "Can't be empty !!!";
        return null;
      },
      onSaved: (String value) {
        data['contacts'] = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    data['doctorid'] = widget.doctorId;

    return AlertDialog(
      title: const Text(
        "Appointment Form",
      ),
      content: createForm(),
      actions: <Widget>[
        OutlineButton(
          textColor: Theme.of(context).primaryColor,
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            _formKey.currentState.save();

            if ((data['problem'] as String).isEmpty ||
                (data['contacts'] as String).isEmpty ||
                (data['date'] as String).isEmpty ||
                data['workingHours'] == null) {
              FlushbarHelper.createError(message: "Invalid data").show(context);
              return;
            }

            context.read<AppointmentActionCubit>().createAppointment(
                  data['doctorid'] as String,
                  data['problem'] as String,
                  data['contacts'] as String,
                  data['date'] as String,
                  data['workingHours'] as WorkingHours,
                );

            Navigator.pop(context);
          },
          child: Text(
            "Submit".toUpperCase(),
          ),
        ),
        OutlineButton(
          textColor: Theme.of(context).errorColor,
          onPressed: Navigator.of(context).pop,
          child: Text(
            "Cancel".toUpperCase(),
          ),
        )
      ],
    );
  }
}
