import 'package:flutter/material.dart';
import 'package:food_app/admin/see_food.dart';

import '../app/utils/app_widget.dart';
import 'add_food.dart';

class HomeFood extends StatefulWidget {
  const HomeFood({super.key});

  @override
  State<HomeFood> createState() => _HomeFoodState();
}

class _HomeFoodState extends State<HomeFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Food"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddFood()),
                  );
                },
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.asset(
                            "assets/images/food.jpg",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        const Text(
                          "Add Food",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0), 
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SeeFood()),
                  );
                },
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.asset(
                            "assets/images/food.jpg", 
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        const Text(
                          "See Food",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
