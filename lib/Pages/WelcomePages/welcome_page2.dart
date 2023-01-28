import 'package:e_commerce/Pages/home_page.dart';
import 'package:flutter/material.dart';

import '../../Components/custom_button.dart';

class WelcomePage2 extends StatelessWidget {
  const WelcomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0, bottom: 10),
                child: Image.asset("assets/images/welcomePage2.png"),
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
                          "Exploring the fashion trends",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            "We form an assortment that follows fashion trends."),
                      ],
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.popUntil(context, (route) => false);
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
                        CustomButton(onTap: (){
                          Navigator.popUntil(context, (route) => false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }, title: 'Next',)
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
