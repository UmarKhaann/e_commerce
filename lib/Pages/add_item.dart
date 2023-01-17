import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'FavoritesPage.dart';
import 'HomePage.dart';
import 'cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  File? _imageFile;
  final storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  String imageUrl = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  Future<void> selectImage() async {
    try {
      final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      setState(() {
        _imageFile = File(pickedFile!.path);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> uploadImage() async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref('/images/${DateTime.now().millisecondsSinceEpoch.toString()}');
      UploadTask uploadTask = ref.putFile(_imageFile!.absolute);

      Future.value(uploadTask).then((value) async {
        var newUrl = await ref.getDownloadURL();
        setState(() {
          imageUrl = newUrl.toString();
        });
        debugPrint("Image uploaded!");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image Added Successfully")));
        setState(() {
          _imageFile = null;
        });
        titleController.clear();
        priceController.clear();
        categoryController.clear();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Add Item",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey[300], shape: BoxShape.circle),
                    child: _imageFile == null
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 70,
                          )
                        :
                        // Image.file(_imageFile!.absolute)
                        CircleAvatar(
                            backgroundImage: FileImage(_imageFile!.absolute),
                          )),
                Positioned(
                  right: 5,
                  bottom: 0,
                  child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: Icon(Icons.add_a_photo, color: Colors.grey[600])),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomInputField(
                controller: titleController,
                labelText: "Enter Title",
                keyboardType: TextInputType.name),
            CustomInputField(
                controller: priceController,
                labelText: "Enter Price",
                keyboardType: TextInputType.number),
            CustomInputField(
                controller: categoryController,
                labelText: "Enter Category",
                keyboardType: TextInputType.name),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () async{
                await uploadImage();
                final db = firestore
                    .collection('Items')
                    .doc(DateTime.now().microsecondsSinceEpoch.toString());
                db.set({
                  "Title": titleController.text.toString(),
                  "Price": priceController.text.toString(),
                  "Category": categoryController.text.toString(),
                  "ImageUrl": imageUrl
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.black),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            currentIndex: 2,
            selectedFontSize: 30,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled, size: 32), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded, size: 32),
                  label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add, size: 32), label: "Add"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag, size: 32), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 32), label: " Person"),
            ],
            onTap: (int index) {
              switch (index) {
                case 0:
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                  break;
                case 1:
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Favorites()));
                  break;
                case 3:
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Cart()));
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  CustomInputField(
      {required this.controller,
      required this.labelText,
      required this.keyboardType,
      Key? key})
      : super(key: key);

  TextEditingController controller;
  String labelText;
  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        keyboardType: keyboardType,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Something";
          }
          return null;
        },
      ),
    );
  }
}
