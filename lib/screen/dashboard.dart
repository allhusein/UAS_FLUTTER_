// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_uas/api/kategori_helper.dart';
import 'package:flutter_uas/screen/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_uas/components/category_models.dart';

import '../api/http_helper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  
  @override
  State<Dashboard> createState() => _Dashboard();


}

class _Dashboard extends State<Dashboard> {
  String token = '';
  String name = '';
  String email = '';
  List listCategory = [];
  TextEditingController etCategory = TextEditingController();
  final ScrollController scrollController = ScrollController();

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      const key = 'token';
      const key1 = 'name';
      const key2 = 'email';
      final value = pref.get(key);
      final value1 = pref.get(key1);
      final value2 = pref.get(key2);
      token = '$value';
      name = '$value1';
      email = '$value2';
    });
  }

  

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("token");
      preferences.clear();
    });
    final response = await HttpHelper().logout(token);
    print(response.body);
  }



  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 66, 5, 55),
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 213, 48, 247),
            ),
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Selamat Datang di Stisla $name',
                      style: TextStyle(
                        color: Color.fromARGB(255, 45, 0, 38),
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.category_rounded,
                            color: Colors.white,
                            size: 29,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/kategoriPage',
                            );
                            logOut();
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          email,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 95, 12, 12),
                            fontWeight: FontWeight.w600,
                            fontSize: 70,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        
                        child: IconButton(
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 29,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/login',
                            );
                            logOut();
                          },
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
