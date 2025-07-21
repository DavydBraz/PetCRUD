import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_crud_dvd/Pages/petsPage.dart';
import 'package:pet_crud_dvd/Pages/settingspage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  final List<Widget> _pages = [    
    PetsPage(),// índice 0     
    SettingsPage(), // índice 1
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AppPet"),),
      
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.pets), label: "Pets"),
          NavigationDestination(
              icon: Icon(Icons.settings), label: "Configs"),
        ],
      ),
      body: _pages[currentPageIndex],
      );
  }
}
