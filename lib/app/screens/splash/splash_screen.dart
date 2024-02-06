import 'package:flutter/material.dart';

import 'package:food_app/app/screens/auth/login_screen.dart';

import '../../utils/app_widget.dart';
import '../../widgets/content_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentIndex = 0;
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            itemCount: contents.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, i) {
              // ignore: prefer_const_constructors
              return Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Image.asset(
                      contents[i].image,
                      height: 450,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      contents[i].titile,
                      style: AppWidget.HeadlinextFieldStyle(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(contents[i].desc,
                        style: AppWidget.LightTextFieldStyle())
                  ],
                ),
              );
            },
          ),
        ),
        // ignore: avoid_unnecessary_containers
        Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  contents.length, (index) => buildDot(index, context))),
        ),
        GestureDetector(
          onTap: () {
            if (currentIndex == contents.length - 1) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LogIn()));
            }
            controller.nextPage(
                duration: const Duration(microseconds: 100),
                curve: Curves.bounceIn);
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(20)),
            height: 60.0,
            margin: const EdgeInsets.all(40.0),
            width: double.infinity,
            child: Center(
                child: Text(
              currentIndex == contents.length - 1 ? "Start" : "Next",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )),
          ),
        )
      ]),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.0,
      width: currentIndex == index ? 18 : 10,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: Colors.black38),
    );
  }
}
