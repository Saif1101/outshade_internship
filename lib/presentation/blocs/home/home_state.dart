part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final bool isSignedIn; 
  final RegisteredUserEntity? currentUser;

  HomeInitial({this.currentUser,this.isSignedIn = false});
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState(this.errorMessage);
}

class RegisterProcessingState extends HomeState {
  final UserModel userModel;


  RegisterProcessingState({required this.userModel});
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<UserModel> users;

  final RegisteredUserEntity? currentUser;
  final List<RegisteredUserEntity?>? registeredUsers;

  HomeLoaded(
      {required this.users,
      this.currentUser,
      this.registeredUsers});
}
