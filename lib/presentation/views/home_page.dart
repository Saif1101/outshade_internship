import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outshade_internship/common/extensions/string_extensions.dart';
import 'package:outshade_internship/data/models/user_model.dart';
import 'package:outshade_internship/domain/entities/registered_user_entity.dart';
import 'package:outshade_internship/presentation/blocs/home/home_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:outshade_internship/presentation/views/details_page.dart';
import 'package:outshade_internship/presentation/views/widgets/registration_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Employees")),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) async {
            if (state is RegisterProcessingState) {
              return await showDialog(
                  useRootNavigator: false,
                  context: context,
                  builder: (ctx) {
                    
                    return BlocProvider<HomeBloc>.value(
                      value: context.read<HomeBloc>(),
                      child: RegistrationForm(userModel: state.userModel)
                    );
                  });
            }
          },
          builder: ((context, state) {
            if (state is HomeInitial) {
              BlocProvider.of<HomeBloc>(context)
                  .add(LoadHomeEvent(registeredUserEntity: state.currentUser));
            }
            if (state is HomeLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeLoaded) {
              bool isSignedIn = state.currentUser != null;
              return Center(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        var user = state.users[index];
                        bool isRegistered = state.registeredUsers
                                ?.any((element) => element?.id == user.id) ??
                            false;

                        print("Is Registered: $isRegistered");

                        return GestureDetector(
                          onLongPress: () {
                            isSignedIn
                                ? Navigator.push(
                                    //handle sign in here
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return EmployeeDetails(
                                          registeredUserEntity: state
                                              .registeredUsers!
                                              .firstWhere((element) =>
                                                  element?.id == user.id)!);
                                    }),
                                  )
                                : () {};
                          },
                          onTap: () {
                            isSignedIn
                                ? user.id == state.currentUser?.id
                                    ? BlocProvider.of<HomeBloc>(context)
                                        .add(SignOutEvent())
                                    : () {}
                                : isRegistered
                                    ? {
                                        BlocProvider.of<HomeBloc>(context).add(
                                            SignInEvent(state.registeredUsers!
                                                .firstWhere((element) =>
                                                    element?.id == user.id)!)),
                                        Navigator.push(
                                          //handle sign in here
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return EmployeeDetails(
                                                registeredUserEntity: state
                                                    .registeredUsers!
                                                    .firstWhere((element) =>
                                                        element?.id ==
                                                        user.id)!);
                                          }),
                                        )
                                      }
                                    : BlocProvider.of<HomeBloc>(context)
                                        .add(RegistrationStartedEvent(user));
                          },
                          child: ListTile(
                            title: Text(user.name),
                            subtitle: Text(user.atype),
                            trailing: isSignedIn
                                ? user.id == state.currentUser?.id
                                    ? Text('Sign Out')
                                    : SizedBox.shrink()
                                : isRegistered
                                    ? Text("Sign-in")
                                    : Text("Un-registered"),
                          ),
                        );
                      }));
            }
            return Center(
              child: Text("Undefined State: $state"),
            );
          }),
        ));
  }
}


