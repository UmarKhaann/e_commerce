import 'package:e_commerce/Components/custom_button.dart';
import 'package:e_commerce/Pages/HomePage.dart';
import 'package:e_commerce/Pages/WelcomePages/WelcomePage2.dart';
import 'package:flutter/material.dart';

class WelcomePage1 extends StatelessWidget {
  const WelcomePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .6,
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0, bottom: 10),
                child: Image.asset("assets/images/welcomePage1.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .35,
                child: Column(
                  children: [
                    Column(
                      children: const [
                        Text(
                          "No more boring things",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            "Picking up accessories from popular Europe brands."),
                      ],
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                        CustomButton(title: "Next", onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const WelcomePage2()));
                        })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
