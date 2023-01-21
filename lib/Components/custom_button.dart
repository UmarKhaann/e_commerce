import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.title,required this.onTap, Key? key}) : super(key: key);
  VoidCallback onTap;
  String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          minimumSize: const Size(100.0, 50.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15))),
      child: const Text(
        "Next",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
