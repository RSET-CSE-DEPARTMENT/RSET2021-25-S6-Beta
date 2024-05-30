import 'package:finance_app/base/scaffold_key.dart';
import 'package:finance_app/easy_loading/easy_loading.dart';
import 'package:finance_app/firebase/firebase_options.dart';
import 'package:finance_app/navigation/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///https://finance-app-79fb8-default-rtdb.firebaseio.com/
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Finance App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: "Archivo"),
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      routerConfig: router,
      builder: EasyLoading.init(),
    );
  }
}
