import 'package:flutter/material.dart';
import 'package:pet_crud_dvd/Pages/homePage.dart';
import 'package:pet_crud_dvd/Pages/settingspage.dart';
import 'package:pet_crud_dvd/utils/app_config.dart';
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode==true?ThemeData.dark():ThemeData.light(),
      //color: Colors.amber,
      home: HomePage(),
    );
  }
}


