import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:apptracker/screens/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAkrP3MQXy6-Adye_00-yGrz4szPqisqPM",
      appId: "1:397829056712:android:1259ef723b681aa3069dfd",
      messagingSenderId: "397829056712",
      projectId: "apptracker-576af",
      storageBucket: "gs://apptracker-576af.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Admin bug tracker",
      debugShowCheckedModeBanner: false,
      // home: Dashboard(),
      home:  HomePage(),
    );
  }
}