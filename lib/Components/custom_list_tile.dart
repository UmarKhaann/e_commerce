import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final imageUrl;
  final title;
  const CustomListTile({
    required this.imageUrl, required this.title,
    Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    spreadRadius: .1,
                    color: Colors.grey.shade300)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * .02, horizontal: 10),
              child: ListTile(
                  horizontalTitleGap: 25,
                  leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.grey,
                                spreadRadius: 1)
                          ],
                          borderRadius:
                          BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: size.width * .08,
                        height: size.height * .08,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset(
                              imageUrl),
                        ),
                      )),
                  title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )))),
    );
  }
}
