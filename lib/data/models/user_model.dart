import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
 final String name;
 final String id;
 final String atype;

  UserModel({required this.name, required this.id, required this.atype});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      id: json['id'],
      atype: json['atype'],
    );
  }

  @override
  List<Object?> get props => [name,id,atype];

  @override
  bool? get stringify => true;
}
