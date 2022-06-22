import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:outshade_internship/data/data_sources/user_local_source.dart';
import 'package:outshade_internship/data/models/user_model.dart';
import 'package:outshade_internship/domain/app_error.dart';
import 'package:outshade_internship/domain/entities/registered_user_entity.dart';



abstract class UserLocalRepository {
  Future<Either<AppError, List<UserModel>>> getUsersFromLocalSource();
  Future<Either<AppError, void>> registerUser(RegisteredUserEntity user); 
  Future<Either<AppError, List<RegisteredUserEntity>>> getRegisteredUsers();
}

