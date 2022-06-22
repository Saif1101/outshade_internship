import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:outshade_internship/data/models/user_model.dart';
import 'package:outshade_internship/domain/entities/registered_user_entity.dart';
import 'package:outshade_internship/domain/usecases/add_user_to_db.dart';
import 'package:outshade_internship/domain/usecases/get_registered_users.dart';
import 'package:outshade_internship/domain/usecases/get_users.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersFromLocalSource getUsersFromLocalSource;
  final RegisterUser registerUser; 
  final GetRegisteredUsers getRegisteredUsers; 

  HomeBloc({
    required this.getRegisteredUsers,
    required this.getUsersFromLocalSource,
    required this.registerUser,
  }) : super(HomeInitial()) {
    on<LoadHomeEvent>(_onLoadHomeEvent);
    on<RegistrationStartedEvent>(_onRegistrationStartedEvent);
    on<RegistrationFinishedEvent>(_onRegistrationFinishedEvent);
    on<SignOutEvent>(_onSignOutEvent);
    on<SignInEvent>(_onSignInEvent);
  }

  Future<void> _onLoadHomeEvent(
      LoadHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final users = await getUsersFromLocalSource(null);
    final registeredUsers = await getRegisteredUsers(null); 
    print("Registered users fetched: ${registeredUsers.isRight()}");
    emit(
      users.fold(
        (l) => HomeErrorState(l.errorMessage),
        (r) => HomeLoaded(
          users: r, 
           currentUser: event.registeredUserEntity,
           registeredUsers: registeredUsers.getOrElse(() => []))));
  }

  Future<void> _onRegistrationStartedEvent(
      RegistrationStartedEvent event, Emitter<HomeState> emit) async {
    emit(RegisterProcessingState(userModel: event.user));
  }

  Future<void> _onRegistrationFinishedEvent(
    RegistrationFinishedEvent event, 
    Emitter<HomeState> emit)async {
      print("registering user: ${event.registeredUserEntity}");
      emit(HomeLoading()); 
      final response = await registerUser(event.registeredUserEntity); 

      emit(response.fold(
        (l) => HomeErrorState(l.errorMessage), 
        (r) => HomeInitial(currentUser: event.registeredUserEntity, isSignedIn: true)
        ));

  }

  Future<void> _onSignOutEvent(SignOutEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial());

  }

  FutureOr<void> _onSignInEvent(SignInEvent event, Emitter<HomeState> emit) {
    emit(HomeInitial(currentUser: event.registeredUserEntity,isSignedIn: true));
  }
}
