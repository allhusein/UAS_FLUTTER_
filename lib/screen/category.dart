import 'package:flutter/material.dart';
import 'package:flutter_uas/api/http_helper.dart';
import 'package:flutter_uas/components/category_models.dart';
import 'package:flutter_uas/api/http_helper.dart';
import 'package:flutter_uas/screen/home.dart';


import 'home.dart';

class categories extends StatefulWidget {
  const categories({super.key, required this.category});

  final Kategori category;
  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  TextEditingController? etCategory;

  doEditCategory() async {
    final name = etCategory?.text;
    final response = await HttpHelper().editCategory(widget.category, name!);
    print(response.body);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  void initState() {
    super.initState();
    etCategory = TextEditingController(text: widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori'),
        backgroundColor: Color.fromARGB(255, 66, 5, 55),
      ),
      body: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                ),
                controller: etCategory,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    fontFamily: 'Raleway',
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 242, 61, 246)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 242, 61, 246),
                    ),
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                width: 90,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 66, 5, 55),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    doEditCategory();
                  },
                  child: const Text(
                    "simpan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
