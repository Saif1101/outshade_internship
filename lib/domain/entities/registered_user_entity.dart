import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'registered_user_entity.g.dart';

@HiveType (typeId:0)
class RegisteredUserEntity extends Equatable{

  @HiveField(0)
  final String name; 

  @HiveField(1)
  final String id; 

  @HiveField(2)
  final String atype;

  @HiveField(3)
  final String gender; 

  @HiveField(4)
  final String dob;

  RegisteredUserEntity({required this.name,required this.id,required this.atype,required this.gender,required this.dob});

  @override
  List<Object?> get props => [id, name, atype, gender, dob];

  @override
  bool? get stringify => true;

  
}