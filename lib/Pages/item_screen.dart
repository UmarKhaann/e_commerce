import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  ItemScreen(
      {
        required this.id,
        required this.isFavorite,
      required this.title,
      required this.price,
      required this.description,
      required this.imageUrl,
      Key? key})
      : super(key: key);

  final String id;
  final bool isFavorite;
  final String title;
  final String price;
  final String description;
  final String imageUrl;

  final fireStore = FirebaseFirestore.instance.collection('Items');

  void setFavorite(snapShot, index) {
    bool fav;
    if (snapShot.data!.docs[index]["isFavorite"] != true) {
      fav = true;
    } else {
      fav = false;
    }
    fireStore
        .doc(snapShot.data!.docs[index].id.toString())
        .update({"isFavorite": fav ?? false});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:  FirebaseFirestore.instance.collection("Items").where('id', isEqualTo: id.toString()).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasError){
          return const Center(child: Text("an error has occurred"));
        }
        return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .45,
                      child: FittedBox(
                          fit: BoxFit.fitWidth, child: Image.network(imageUrl)),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .55,
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .45,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .55,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                          color: Colors.white),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.w500),
                                ),
                                Text('$price \$',
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w900)),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Description',
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              description,
                              style: const TextStyle(
                                  height: 1.5, fontSize: 16, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Choose Size',
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CustomSizeWidget(title: "S"),
                                  CustomSizeWidget(title: "M"),
                                  CustomSizeWidget(title: "L"),
                                  CustomSizeWidget(title: "XL"),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Center(
                              child: SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.add),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Add To Cart",
                                            style:
                                            TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 40,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.arrow_back_ios, size: 20)),
                        IconButton(onPressed: (){
                          setFavorite(snapshot, 0);


                        }, icon: snapshot.data!.docs[0]['isFavorite']? const Icon(Icons.favorite): const Icon(Icons.favorite_outline)),
                      ],
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }
}

class CustomSizeWidget extends StatelessWidget {
  final String title;

  const CustomSizeWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CircleAvatar(
        radius: 35,
        backgroundColor: Colors.grey[300],
        child: Text(
          title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
