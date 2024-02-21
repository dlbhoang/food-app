import 'package:flutter/material.dart';
import 'package:food_app/admin/home_food.dart';
import 'package:food_app/admin/see_food.dart';
import '../app/utils/app_widget.dart';
import 'add_food.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Home Admin",
                  style: AppWidget.HeadlinextFieldStyle(),
                ),
              ),
              const SizedBox(height: 50.0,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeFood()),
                  );
                },
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(
                              "assets/images/default.jpg",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 30.0,),
                          const Text(
                            "User",
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
              ),
              const SizedBox(height: 20.0,), 
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SeeFood()), // Navigate to the SeeFood page
                  );
                },
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
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
                          const SizedBox(width: 30.0,),
                          const Text(
                            "Food",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
