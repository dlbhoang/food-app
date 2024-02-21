import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/app/screens/detail/detail_screen.dart';
import 'package:food_app/app/services/database.dart';

import '../../services/shared_prefences.dart';
import '../../utils/app_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool icecream = false, pizza = false, salad = false, buger = false;

  Stream? foodItemStream;
  String? name;

  ontheload() async {
    foodItemStream = DatabaseMethods().getFoodItemByCategory("Pizza");
    name = await SharedPreferenceHelper().getUserName();

    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            detail: ds["Detail"],
                            image: ds["Image"],
                            price: ds["Price"],
                            name: ds["Name"],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds['Image'],
                                  height: 150.0,
                                  width: 150.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(ds['Name'],
                                  style: AppWidget.LightTextFieldStyle()),
                              const SizedBox(height: 5.0),
                              Text("Fresh and Healthy",
                                  style: AppWidget.SemiBoldTextFieldStyle()),
                              const SizedBox(height: 5.0),
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                "\$" + ds['Price'],
                                style: AppWidget.LightTextFieldStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : const CircularProgressIndicator();
      },
      stream: foodItemStream,
    );
  }

  Widget allItemsVertical() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            detail: ds["Detail"],
                            image: ds["Image"],
                            price: ds["Price"],
                           name: ds["Name"],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds["Image"],
                                  height: 85.0,
                                  width: 85.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.0,
                                    child: Text(
                                      ds["Name"],
                                      style: AppWidget.boldTextFieldStyle(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.0,
                                    child: Text(
                                      ds["Detail"],
                                      style: AppWidget.SemiBoldTextFieldStyle(),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.0,
                                    // ignore: prefer_interpolation_to_compose_strings
                                    child: Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "\$" + ds["Price"],
                                      style: AppWidget.LightTextFieldStyle(),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : const CircularProgressIndicator();
      },
      stream: foodItemStream,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name != null ? 'Hello $name' : 'Hello Guest',
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text("Delicious Food", style: AppWidget.HeadlinextFieldStyle()),
              Text("Discover and Get Great Food",
                  style: AppWidget.LightTextFieldStyle()),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: showItem()),
              const SizedBox(
                height: 20.0,
              ),
              Container(height: 270, child: allItems()),
              const SizedBox(
                height: 5.0,
              ),
              allItemsVertical(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            pizza = true;
            icecream = false;
            salad = false;
            buger = false;
            foodItemStream = DatabaseMethods().getFoodItemByCategory("Pizza");
            setState(() {});
          },
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: pizza ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/pizza.png",
                    height: 40.0,
                    width: 40.0,
                    fit: BoxFit.cover,
                    color: pizza ? Colors.white : Colors.black,
                  ))),
        ),
        GestureDetector(
          onTap: () async {
            pizza = false;
            icecream = true;
            salad = false;
            buger = false;
            foodItemStream = DatabaseMethods().getFoodItemByCategory("Ice-cream");

            setState(() {});
          },
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: icecream ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/ice-cream.png",
                    height: 40.0,
                    width: 40.0,
                    fit: BoxFit.cover,
                    color: icecream ? Colors.white : Colors.black,
                  ))),
        ),
        GestureDetector(
          onTap: () async {
            pizza = false;
            icecream = false;
            salad = true;
            buger = false;
            foodItemStream = DatabaseMethods().getFoodItemByCategory("Salad");

            setState(() {});
          },
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: salad ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/salad.png",
                    height: 40.0,
                    width: 40.0,
                    fit: BoxFit.cover,
                    color: salad ? Colors.white : Colors.black,
                  ))),
        ),
        GestureDetector(
          onTap: () async {
            pizza = false;
            icecream = false;
            salad = false;
            buger = true;
            foodItemStream = DatabaseMethods().getFoodItemByCategory("Burger");

            setState(() {});
          },
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: buger ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/burger.png",
                    height: 40.0,
                    width: 40.0,
                    fit: BoxFit.cover,
                    color: buger ? Colors.white : Colors.black,
                  ))),
        )
      ],
    );
  }
}
