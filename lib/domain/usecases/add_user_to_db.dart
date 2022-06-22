
import 'package:dartz/dartz.dart';
import 'package:outshade_internship/domain/app_error.dart';
import 'package:outshade_internship/domain/entities/registered_user_entity.dart';
import 'package:outshade_internship/domain/repositories/user_local_source_repository.dart';
import 'package:outshade_internship/domain/usecases/usecase.dart';

class RegisterUser extends UseCase<void,RegisteredUserEntity>{
  final UserLocalRepository userLocalRepository;

  RegisterUser(this.userLocalRepository);

  @override
  Future<Either<AppError, void>> call(RegisteredUserEntity params) async {
       return await userLocalRepository.registerUser(params);
  }
}
