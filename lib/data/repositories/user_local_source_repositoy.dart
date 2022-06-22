import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:outshade_internship/data/data_sources/user_local_source.dart';
import 'package:outshade_internship/data/models/user_model.dart';
import 'package:outshade_internship/domain/app_error.dart';
import 'package:outshade_internship/domain/entities/registered_user_entity.dart';
import 'package:outshade_internship/domain/repositories/user_local_source_repository.dart';

class UserLocalRepositoryImpl extends UserLocalRepository{
  final UserDataSource userDataSource;

  UserLocalRepositoryImpl(this.userDataSource); 
  
  @override
  Future<Either<AppError, List<RegisteredUserEntity>>> getRegisteredUsers() async {
    try{
      final response = await userDataSource.getRegisteredUsers();
      return Right(response); 
    } on SocketException {
      return Left(AppError(errorMessage: 'Socket exception.'));
    } on Exception catch (e){
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<UserModel>>> getUsersFromLocalSource() async {
    try{
      final response = await userDataSource.getUsers();
      return Right(response); 
    } on SocketException {
      return Left(AppError(errorMessage: 'Socket exception.'));
    } on Exception catch (e){
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> registerUser(RegisteredUserEntity user) async {
    try{
      final response = await userDataSource.registerUser(user);
      return Right(response); 
    } on SocketException {
      return Left(AppError(errorMessage: 'Socket exception.'));
    } on Exception catch (e){
      return Left(AppError(errorMessage: e.toString()));
    }
  }
}