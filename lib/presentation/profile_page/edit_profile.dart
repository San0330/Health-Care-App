import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../application/auth_bloc/auth_bloc.dart';
import '../../application/profile_cubit/profile_cubit.dart';
import 'provider/edit_profile_form_provider.dart';

class EditProfile extends StatelessWidget {
  static String routeName = '/edit-profile';

  const EditProfile();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileProvider>(
      create: (context) {
        final user =
            (context.read<AuthBloc>().state as Authenticated).authenticatedUser;

        return EditProfileProvider(
          name: user.name,
          email: user.email,
          dob: user.dob,
          contact: user.contact,
          citizenId: user.citizenId,
          gender: user.gender,
        );
      },
      child: const MyEditProfile(),
    );
  }
}

class MyEditProfile extends StatefulWidget {
  const MyEditProfile();

  @override
  _MyEditProfileState createState() => _MyEditProfileState();
}

class _MyEditProfileState extends State<MyEditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProfileProvider>(context);

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateFailed) {
          FlushbarHelper.createError(message: "Profile update failed").show(context);
        } else if (state is ProfileUpdateSuccess) {
          FlushbarHelper.createSuccess(message: "Profile updated").show(context);
          context.read<AuthBloc>().add(const CheckAuth());
          Navigator.pop(context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Edit profile"),
          ),
          body: Container(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: provider.name,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (String value) {
                      if (value.isEmpty) return "Can't be empty !!!";
                      return null;
                    },
                    onChanged: (value) => provider.update(newName: value),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: provider.contact,
                    decoration: const InputDecoration(labelText: 'Contact NO.'),
                    validator: (String value) {
                      if (value.isEmpty) return "Can't be empty !!!";
                      return null;
                    },
                    onChanged: (value) => provider.update(newContact: value),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: provider.email,
                    decoration: const InputDecoration(labelText: 'Email Id'),
                    validator: (String value) {
                      value = value.trim();
                      if (value.isEmpty) return "Can't be empty !!!";
                      return null;
                    },
                    onChanged: (value) => provider.update(newEmail: value),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: provider.citizenId,
                    decoration: const InputDecoration(labelText: 'Citizen Id'),
                    validator: (String value) {
                      value = value.trim();
                      if (value.isEmpty) return "Can't be empty !!!";
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.only(top: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Date:'),
                        Text(provider.dob ?? 'null'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlineButton(
                    onPressed: () async {
                      final getDate =
                          await buildShowDatePicker(context, provider.dob);

                      if (getDate != null) {
                        provider.update(
                          newdob:
                              "${getDate.year}/${getDate.month}/${getDate.day}",
                        );
                      }
                    },
                    child: const Text("Update Date of Birth"),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: <Widget>[
                      const Text("Gender:"),
                      Row(
                        children: <Widget>[
                          const Text("MALE"),
                          Radio<String>(
                            value: 'male',
                            groupValue: provider.gender,
                            onChanged: (value) {
                              provider.update(newGender: value);
                            },
                          ),
                          const Text("FEMALE"),
                          Radio<String>(
                            value: 'female',
                            groupValue: provider.gender,
                            onChanged: (value) {
                              provider.update(newGender: value);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5.0),
                    child: RaisedButton(
                      onPressed: () => _submitform(provider),
                      color: Colors.blue,
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime> buildShowDatePicker(BuildContext context, String dob) =>
      showDatePicker(
        context: context,
        initialDate: DateTime.parse(dob),
        firstDate: DateTime(1950),
        lastDate: DateTime(2015),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        },
      );

  Future _submitform(EditProfileProvider provider) async {
    if (!_formKey.currentState.validate()) return;

    if (provider.gender.isEmpty || provider.dob.isEmpty) {
      String message;
      if (provider.gender.isEmpty) {
        message = 'Please update gender';
      } else if (provider.dob.isEmpty) {
        message = "Please update your date of birth";
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Warning"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              onPressed: () => Navigator.pop(context),
              child: const Text("Okay"),
            ),
          ],
        ),
      );

      return;
    }

    context.read<ProfileCubit>().updateProfile(
          name: provider.name,
          email: provider.email,
          gender: provider.gender,
          contact: provider.contact,
          citizenId: provider.citizenId,
          dob: provider.dob,
        );
  }
}
