

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:outshade_internship/data/data_sources/user_local_source.dart';
import 'package:outshade_internship/data/repositories/user_local_source_repositoy.dart';
import 'package:outshade_internship/domain/entities/registered_user_entity.dart';
import 'package:outshade_internship/domain/usecases/add_user_to_db.dart';
import 'package:outshade_internship/domain/usecases/get_registered_users.dart';
import 'package:outshade_internship/domain/usecases/get_users.dart';
import 'package:outshade_internship/presentation/blocs/home/home_bloc.dart';
import 'package:outshade_internship/presentation/views/home_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.registerAdapter(RegisteredUserEntityAdapter());
  Hive.init(appDocumentDir.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => UserLocalRepositoryImpl(UserDataSouceImpl()),
        child: BlocProvider(
          create: (context) => HomeBloc(
            getUsersFromLocalSource: GetUsersFromLocalSource(context.read<UserLocalRepositoryImpl>()),
            registerUser: RegisterUser(context.read<UserLocalRepositoryImpl>()), 
            getRegisteredUsers: GetRegisteredUsers(context.read<UserLocalRepositoryImpl>()) ,
          ),
          child: HomePage(),
        ),
      ),
    );
  }
}
