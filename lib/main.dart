import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/firebase_options.dart';
import 'package:todo_list_app/services/auth_services.dart';
import 'package:todo_list_app/services/task_sevices.dart';
import 'package:todo_list_app/view/auth/auth_state_widget.dart';
import 'package:todo_list_app/viewmodels/auth_viewmodel.dart';
import 'package:todo_list_app/viewmodels/task_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => AuthViewModel(AuthService())),
        ChangeNotifierProvider(create: (_) => TaskViewModel(TaskServices())),
      ],
      child: Builder(
        builder: (context) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: AuthStateWidget(),
          );
        },
      ),
    );
  }
}
