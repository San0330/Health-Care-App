import 'package:flutter/widgets.dart';

class EditProfileProvider extends ChangeNotifier {
  String _name = "";
  String _citizenId = "";
  String _contact = "";
  String _email = "";
  String _dob = "";
  String _gender = "";
  bool _showErrors = false;

  EditProfileProvider({
    String name,
    String citizenId,
    String contact,
    String email,
    String dob,
    String gender,
  })  : _name = name,
        _citizenId = citizenId,
        _contact = contact,
        _email = email,
        _dob = dob,
        _gender = gender;

  bool get showErrors => _showErrors;

  String get dob => _dob;
  String get citizenId => _citizenId;
  String get contact => _contact;
  String get email => _email;
  String get name => _name;
  String get gender => _gender;

  void enableErrorMessages() {
    _showErrors = true;
    notifyListeners();
  }

  void update({
    String newName,
    String newEmail,
    String newCitizenId,
    String newContact,
    String newdob,
    String newGender,
  }) {
    _name = newName ?? _name;
    _email = newEmail ?? _email;
    _citizenId = newCitizenId ?? _citizenId;
    _contact = newContact ?? _contact;
    _dob = newdob ?? _dob;
    _gender = newGender ?? _gender;

    notifyListeners();
  }

  @override
  String toString() {
    return 'EditProfileProvider(_name: $_name, _citizenId: $_citizenId, _contact: $_contact, _email: $_email, _dob: $_dob, _gender: $_gender, _showErrors: $_showErrors)';
  }
}
