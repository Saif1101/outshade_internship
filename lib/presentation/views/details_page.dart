import 'package:flutter/material.dart';
import 'package:outshade_internship/domain/entities/registered_user_entity.dart';

class EmployeeDetails extends StatelessWidget {
  final RegisteredUserEntity registeredUserEntity; 

  const EmployeeDetails({ Key? key, required this.registeredUserEntity }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Name: ${registeredUserEntity.name}'), 
            Text('ID: ${registeredUserEntity.id}'), 
            Text('Appointment Type: ${registeredUserEntity.atype}'), 
            Text('Gender: ${registeredUserEntity.gender}'),
            Text('Date Of Birth: ${registeredUserEntity.dob}'), 
          ],
        ),
      ),
    );
  }
}