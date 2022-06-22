part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeEvent extends HomeEvent{
  final RegisteredUserEntity? registeredUserEntity;

  LoadHomeEvent({this.registeredUserEntity}); 
  
}

class SignInEvent extends HomeEvent{
  final RegisteredUserEntity registeredUserEntity;

  SignInEvent(this.registeredUserEntity); 
  
}

class SignOutEvent extends HomeEvent{}

class RegistrationStartedEvent extends HomeEvent{
  final UserModel user;

  RegistrationStartedEvent(this.user); 
}

class RegistrationFinishedEvent extends HomeEvent{
  final RegisteredUserEntity registeredUserEntity;

  RegistrationFinishedEvent(this.registeredUserEntity); 

}
