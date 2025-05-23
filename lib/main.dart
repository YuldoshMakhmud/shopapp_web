import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseshop_web/views/main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: kIsWeb|| Platform.isAndroid? FirebaseOptions(
    apiKey:"AIzaSyAddWmoKBFR3_QnDoEkWJE6slse8vso7q8", 
    appId: "1:387488316116:web:2dd3b5ff9a85dbb3be9941",
    messagingSenderId:"387488316116", 
     storageBucket: "my-shop-e7b87.firebasestorage.app",
    projectId:"my-shop-e7b87"):null
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}

