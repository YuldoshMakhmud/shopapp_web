import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseshop_web/views/widget/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CategoriesScreen extends StatefulWidget {
  static const String id = '\categoryScreen';
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String categoryName;
  dynamic _image;
  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  Future<String> _uploadImageToStorage(dynamic image) async {
    String safeFileName = fileName!
        .replaceAll(RegExp(r'[^\w\s]+'), '') // belgilarni olib tashlash
        .replaceAll(' ', '_'); // bo‘sh joylarni _ bilan almashtirish

    Reference ref = _firebaseStorage
        .ref()
        .child('categories')
        .child(safeFileName);

    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  uploadToFirebase() async {
    if (_formKey.currentState!.validate()) {
      if (_image != null) {
        EasyLoading.show(status: 'Saving...');
        try {
          String imageUrl = await _uploadImageToStorage(_image);

          String safeDocName = fileName!
              .replaceAll(RegExp(r'[^\w\s]+'), '')
              .replaceAll(' ', '_');

          await _firestore.collection('categories').doc(safeDocName).set({
            'categoryImage': imageUrl,
            'categoryName': categoryName,
          });

          EasyLoading.showSuccess('Category Saved!');
          setState(() {
            _formKey.currentState!.reset();
            _image = null;
          });
        } catch (e) {
          EasyLoading.showError('Error: $e');
        }
      } else {
        EasyLoading.showError('Please select an image');
      }
    } else {
      EasyLoading.showError('Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
              ),
            ),
            const Divider(color: Colors.grey),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 140,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            border: Border.all(color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child:
                                _image != null
                                    ? Image.memory(_image, fit: BoxFit.cover)
                                    : const Text('No Image'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3C55EF),
                          ),
                          onPressed: pickImage,
                          child: const Text(
                            'Pick Image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Category Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter category name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          categoryName = value;
                        },
                      ),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: uploadToFirebase,
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _formKey.currentState?.reset();
                          _image = null;
                        });
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.grey),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Category List',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
              ),
            ),
            const SizedBox(height: 15),
            const CategoryListWidget(),
          ],
        ),
      ),
    );
  }
}
