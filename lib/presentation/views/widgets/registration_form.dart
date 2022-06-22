import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:outshade_internship/common/extensions/string_extensions.dart';
import 'package:outshade_internship/data/models/user_model.dart';
import 'package:outshade_internship/domain/entities/registered_user_entity.dart';
import 'package:outshade_internship/presentation/blocs/home/home_bloc.dart';

class RegistrationForm extends StatefulWidget {
  final UserModel userModel;

  const RegistrationForm({Key? key, required this.userModel}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController dobController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "What is your gender?",
                style: TextStyle(fontSize: 18),
              ),
              Divider(),
              ListTile(
                title: Text("Male"),
                leading: Radio(
                    value: "Male",
                    groupValue: genderController.text,
                    onChanged: (value) {
                      setState(() {
                        genderController.text = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: Text("Female"),
                leading: Radio(
                    value: "Female",
                    groupValue: genderController.text,
                    onChanged: (value) {
                      setState(() {
                        genderController.text = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: Text("Other"),
                leading: Radio(
                    value: "Other",
                    groupValue: genderController.text,
                    onChanged: (value) {
                      setState(() {
                        genderController.text = value.toString();
                      });
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime.now(), onChanged: (date) {
                        setState(() {
                          dobController.text = date.toString().getDateTime();
                        });
                      }, currentTime: DateTime.now());
                    },
                    child: Text(
                      'Select Date of Birth',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Text(
                dobController.text,
                style: TextStyle(color: Colors.black),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      print(
                          'Dob is ${dobController.text} and gender is ${genderController.text}');
                      BlocProvider.of<HomeBloc>(context).add(
                          RegistrationFinishedEvent(RegisteredUserEntity(
                              atype: widget.userModel.atype,
                              dob: '2001/02/11',
                              gender: 'M',
                              id: widget.userModel.id,
                              name: widget.userModel.name)));
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ));
  }
}
