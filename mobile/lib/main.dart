import 'package:flutter/material.dart';
import 'package:mobile/models/reservations.dart';
import 'package:mobile/screens/splash_screen/splash.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_)=>User(),
      ),
      ChangeNotifierProvider(
          create: (_)=>Reservations())
    ],child: const MyApp(),)

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Parking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    );
  }
}
