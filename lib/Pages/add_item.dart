import 'dart:async';
import 'package:e_commerce/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
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

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  final titleFocusNode = FocusNode();
  final priceFocusNode = FocusNode();
  final categoryFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

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
            String id = DateTime.now().microsecondsSinceEpoch.toString();
            final db = firestore
                .collection('Items')
                .doc(id);
            List<String> array = categoryController.text.trim().toString().split(",");
            db.set({
              "id": id,
              "title": titleController.text.toString(),
              "price": priceController.text.toString(),
              "category": array,
              "description": descriptionController.text.toString(),
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
            descriptionController.clear();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        } else {
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
    descriptionController.dispose();
    titleFocusNode.dispose();
    priceFocusNode.dispose();
    categoryFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * .01),
              child: Column(
                children: [
                  Stack(children: [
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
                            icon: Icon(Icons.add_a_photo,
                                color: Colors.grey[600])))
                  ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        CustomInputField(
                            icon: const Icon(Icons.edit),
                            controller: titleController,
                            focusNode: titleFocusNode,
                            labelText: "Enter Title",
                            keyboardType: TextInputType.name),
                        CustomInputField(
                            icon: const Icon(Icons.attach_money),
                            controller: priceController,
                            focusNode: priceFocusNode,
                            labelText: "Enter Price",
                            keyboardType: TextInputType.number),
                        CustomInputField(
                            icon: const Icon(Icons.folder),
                            controller: categoryController,
                            focusNode: categoryFocusNode,
                            labelText: "Enter Category",
                            keyboardType: TextInputType.name),
                        CustomInputField(
                            icon: const Icon(Icons.description),
                            controller: descriptionController,
                            focusNode: descriptionFocusNode,
                            labelText: "Enter Description",
                            keyboardType: TextInputType.name)
                      ])),
                  SizedBox(height: MediaQuery.of(context).size.height *.12),
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
            ),
          );
        },
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {required this.controller,
      required this.labelText,
      required this.keyboardType,
      required this.icon,
        required this.focusNode,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final Icon icon;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        validator: (value) {
          return value!.isEmpty ? "Field cannot be empty" : null;
        },
        controller: controller,
        focusNode: focusNode,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            prefixIcon: icon,
            labelText: labelText,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        keyboardType: keyboardType,
      ),
    );
  }
}
