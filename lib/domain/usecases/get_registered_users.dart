
import 'package:dartz/dartz.dart';
import 'package:outshade_internship/domain/app_error.dart';
import 'package:outshade_internship/domain/entities/registered_user_entity.dart';
import 'package:outshade_internship/domain/repositories/user_local_source_repository.dart';
import 'package:outshade_internship/domain/usecases/usecase.dart';

class GetRegisteredUsers extends UseCase<List<RegisteredUserEntity>,void>{
  final UserLocalRepository userLocalRepository;

  GetRegisteredUsers(this.userLocalRepository); 
  @override
  Future<Either<AppError, List<RegisteredUserEntity>>> call(void params) async {
    return await userLocalRepository.getRegisteredUsers();
  }
  
}