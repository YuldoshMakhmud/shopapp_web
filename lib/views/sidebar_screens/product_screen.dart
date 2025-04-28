import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static const String id = '\productscreen';

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final TextEditingController _sizeController = TextEditingController();
   final List<String> _sizeList = [];
  final List<String> _categoryList = [];
  String? selectedCategory;
  bool _isEntered = false;
  final List<Uint8List> _images = [];
  chooseImage() async {
    final pickedImages = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (pickedImages == null) {
      print('No Image Picked');
    } else {
      setState(() {
        for (var file in pickedImages.files) {
          _images.add(file.bytes!);
        }
      });
    }
  }

  _getCategories() {
    return _firestore.collection('categories').get().then((
      QuerySnapshot querySnapshot,
    ) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Product Information',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Product Name',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(child: buildDropDownField()),
                SizedBox(width: 20),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Price',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Discount price',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: _sizeController,
                      onChanged: (value) {
                        setState(() {
                          _isEntered = true;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Add Size',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                _isEntered == true
                    ? Flexible(
                      child: ElevatedButton(
                        onPressed: () {
                          _sizeList.add(_sizeController.text);

                          print(_sizeList);
                        },
                        child: const Text('Add'),
                      ),
                    )
                    : const Text(''),
              ],
            ),
            SizedBox(height: 20),

            GridView.builder(
              itemCount: _images.length + 1,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                      child: IconButton(
                        onPressed: () {
                          chooseImage();
                        },
                        icon: const Icon(Icons.add),
                      ),
                    )
                    : Image.memory(_images[index - 1]);
              },
            ),

            InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Text(
                    'Upload Product',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget buildDropDownField() {
    return DropdownButtonFormField(
      onChanged: (String? value) {
        if (value != null) {
          setState(() {
            selectedCategory = value;
          });
        }
      },
      items:
          _categoryList.map((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
      decoration: InputDecoration(
        labelText: 'Select category',
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
    );
  }
}
