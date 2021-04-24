import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/diagnosis_cubit/diagnosis_cubit.dart';

class SelectedConditionsChips extends StatelessWidget {
  const SelectedConditionsChips({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchState =
        context.watch<DiagnosisCubit>().state as DiagnosisSearchState;

    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: Wrap(
              spacing: 4.0,
              children: searchState.selectedConditions.reversed
                  .map(
                    (e) => Chip(
                      label: Text(e.name),
                    ),
                  )
                  .toList(),
            ),
          ),
          RaisedButton(
            color: Colors.blue,
            onPressed: () {
              context.read<DiagnosisCubit>().submit();
            },
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
