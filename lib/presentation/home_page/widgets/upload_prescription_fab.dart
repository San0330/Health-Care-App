import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../application/prescription_cubit/prescribtion_cubit.dart';
import '../../res/styling.dart';

class UploadPrescriptionFAB extends StatelessWidget {
  const UploadPrescriptionFAB({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return FloatingActionButton(
      heroTag: 'upload_prescribtion',
      backgroundColor: Theme.of(ctx).primaryColor,
      foregroundColor: AppTheme.floatingButtonForegroundColor,
      tooltip: "Upload prescription",
      onPressed: () {
        showUploadDialog(ctx);
      },
      child: const Icon(
        FontAwesomeIcons.fileUpload,
      ),
    );
  }

  void showUploadDialog(BuildContext ctx) => showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: const Text("Upload Prescription ?"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: const Text(
              "Please upload a clear picture of your prescription.",
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: AppTheme.dangerColor),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  context
                      .read<PrescribtionCubit>()
                      .uploadPrescriptionImage(fromGallery: false);
                },
                child: const Text("Okay"),
              ),
            ],
          );
        },
      );
}
