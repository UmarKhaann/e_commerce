import 'dart:async';
import 'package:e_commerce/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
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
  final storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  Future<void> selectImage() async {
    final itemProvider = Provider.of<ItemsProvider>(context, listen: false);
    try {
      final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      itemProvider.setImageFile(pickedFile!.path);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> uploadItem() async {
    final itemProvider = Provider.of<ItemsProvider>(context, listen: false);
    try {
      if (_formKey.currentState!.validate()) {
        if (itemProvider.imageFile != null) {
          itemProvider.setIsLoading(true);
          Reference ref = FirebaseStorage.instance.ref(
              '/images/${DateTime.now().millisecondsSinceEpoch.toString()}');

          UploadTask uploadTask = ref.putFile(itemProvider.imageFile!.absolute);
          Future.value(uploadTask).then((value) async {
            var newUrl = await ref.getDownloadURL();
            final db = firestore
                .collection('Items')
                .doc(DateTime.now().microsecondsSinceEpoch.toString());
            db.set({
              "title": titleController.text.toString(),
              "price": priceController.text.toString(),
              "category": categoryController.text.toString(),
              "imageUrl": newUrl,
              "isFavorite": false,
            }).then((value) {
              debugPrint("Image uploaded!");
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Item Added Successfully")));
            }).onError((error, stackTrace) {
              debugPrint(error.toString());
            });

            itemProvider.setImageFile(null);
            itemProvider.setIsLoading(false);

            titleController.clear();
            priceController.clear();
            categoryController.clear();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("First select an Image to upload")));
        }
      }
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
      body: Consumer<ItemsProvider>(
        builder: (BuildContext context, itemProvider, Widget? child) {
          return Container(
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
                        child: itemProvider.imageFile == null
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 70,
                              )
                            :
                            // Image.file(_imageFile!.absolute)
                            CircleAvatar(
                                backgroundImage:
                                    FileImage(itemProvider.imageFile!.absolute),
                              )),
                    Positioned(
                      right: 5,
                      bottom: 0,
                      child: IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          icon:
                              Icon(Icons.add_a_photo, color: Colors.grey[600])),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInputField(
                            prefix: const Icon(Icons.edit),
                            controller: titleController,
                            labelText: "Enter Title",
                            keyboardType: TextInputType.name),
                        CustomInputField(
                            prefix: const Text("\$"),
                            controller: priceController,
                            labelText: "Enter Price",
                            keyboardType: TextInputType.number),
                        CustomInputField(
                            prefix: const Text(""),
                            controller: categoryController,
                            labelText: "Enter Category",
                            keyboardType: TextInputType.name),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Expanded(child: Container()),
                itemProvider.isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 18.0),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: Colors.black,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          uploadItem();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 15),
                          child: Text("Add"),
                        ),
                      ),
              ],
            ),
          );
        },
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
  const CustomInputField(
      {required this.controller,
      required this.labelText,
      required this.keyboardType,
      required this.prefix,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final Widget prefix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Field cannot be empty";
          } else {
            return null;
          }
        },
        controller: controller,
        decoration: InputDecoration(
            prefix: prefix,
            labelText: labelText,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        keyboardType: keyboardType,
      ),
    );
  }
}
