import 'package:flutter/material.dart';
import 'package:flutter_uas/screen/home.dart';



class bar  extends StatefulWidget {
  const bar({super.key});

  @override
  State<bar> createState() => _bar();
  
}

class _bar extends State<bar> {
  int currentPageIndex = 0;

 @override
  Widget build(BuildContext context) {
     return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Kategori',
          ),
        ],
      ),
      body: <Widget>[
        const Home(),
        
      ][currentPageIndex],
    );
  }
}
 

