import 'package:outshade_internship/data/models/user_model.dart';
import 'package:outshade_internship/domain/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:outshade_internship/domain/repositories/user_local_source_repository.dart';
import 'package:outshade_internship/domain/usecases/usecase.dart';

class GetUsersFromLocalSource extends UseCase<List<UserModel>,void>{
  final UserLocalRepository userLocalRepository;

  GetUsersFromLocalSource(this.userLocalRepository); 
  @override
  Future<Either<AppError, List<UserModel>>> call(void params) async {
    return await userLocalRepository.getUsersFromLocalSource();
  }
  
}