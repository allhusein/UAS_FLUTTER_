// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_uas/api/kategori_helper.dart';
import 'package:flutter_uas/screen/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_uas/components/category_models.dart';

import '../api/http_helper.dart';

class kategoriPage extends StatefulWidget {
  const kategoriPage({super.key});

  
  @override
  State<kategoriPage> createState() => _kategoriPage();


}

class _kategoriPage extends State<kategoriPage> {
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

  getKategori() async {
    final response = await HttpHelper().getKategori();
    var dataResponse = jsonDecode(response.body);
    setState(() {
      var listRespon = dataResponse['data'];
      for (var i = 0; i < listRespon.length; i++) {
        listCategory.add(Kategori.fromJson(listRespon[i]));
      }
    });
  }

  doAddCategory() async {
    final name = etCategory.text;
    final response = await CategoryService().addCategory(name);
    print(response.body);
    listCategory.clear();
    getKategori();
    etCategory.clear();
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
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        
      }
    });

    
  }
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 66, 5, 55),
      body: Column(
        children: [  
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 218, 189, 222),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.zero,
                  topLeft: Radius.zero,
                ),
              ),
              child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 30.0,
              ),
                itemCount: listCategory.length,
                itemBuilder: (context, index) {
                  var kategori = listCategory[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Color.fromARGB(255, 208, 105, 240),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.create_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Color.fromARGB(255, 172, 12, 172),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onDismissed: (DismissDirection direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  categories(category: listCategory[index]),
                            ));
                      } else {
                        final response = await HttpHelper()
                            .deleteCategory(listCategory[index]);
                        print(response.body);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 7,
                            offset: Offset(6.0, 6.0),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            kategori.name,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: TextFormField(
              controller: etCategory,
              decoration: InputDecoration(
                hintText: "Masukan Kategori",
                hintStyle: const TextStyle(fontFamily: 'Raleway'),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 201, 19, 192),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text("Add"),
                    onPressed: () {
                      doAddCategory();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
