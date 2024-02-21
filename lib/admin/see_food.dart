import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/admin/update_food.dart';
import 'package:food_app/app/utils/app_widget.dart';

import '../app/services/database.dart';

class SeeFood extends StatefulWidget {
  const SeeFood({super.key});

  @override
  State<SeeFood> createState() => _SeeFoodState();
}

class _SeeFoodState extends State<SeeFood> {
  late Stream<QuerySnapshot> foodItemStream;
  bool icecream = false, pizza = true, salad = false, burger = false;

  @override
  void initState() {
    super.initState();
    _loadAllFoodItems();
  }

  void _loadAllFoodItems() {
    foodItemStream = DatabaseMethods().getAllFoodItems();
  }

  Widget allItemsVertical() {
    return StreamBuilder<QuerySnapshot>(
      stream: foodItemStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateFoodItem(foodItemId: ds.id),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
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
                              width: MediaQuery.of(context).size.width / 2.0,
                              child: Text(
                                ds["Name"],
                                style: AppWidget.boldTextFieldStyle(),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.0,
                              child: Text(
                                ds["Detail"],
                                style: AppWidget.SemiBoldTextFieldStyle(),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.0,
                              child: Text(
                                "\$" + ds["Price"],
                                style: AppWidget.LightTextFieldStyle(),
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 30),
                          onPressed: () {
                            _deleteItem(ds.reference);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            _loadItemsByCategory("Pizza");
          },
          child: _categoryIcon(
            assetPath: "assets/images/pizza.png",
            selected: pizza,
          ),
        ),
        GestureDetector(
          onTap: () async {
            _loadItemsByCategory("Ice-cream");
          },
          child: _categoryIcon(
            assetPath: "assets/images/ice-cream.png",
            selected: icecream,
          ),
        ),
        GestureDetector(
          onTap: () async {
            _loadItemsByCategory("Salad");
          },
          child: _categoryIcon(
            assetPath: "assets/images/salad.png",
            selected: salad,
          ),
        ),
        GestureDetector(
          onTap: () async {
            _loadItemsByCategory("Burger");
          },
          child: _categoryIcon(
            assetPath: "assets/images/burger.png",
            selected: burger,
          ),
        ),
      ],
    );
  }

  Widget _categoryIcon({required String assetPath, required bool selected}) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          assetPath,
          height: 40.0,
          width: 40.0,
          fit: BoxFit.cover,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  void _loadItemsByCategory(String category) async {
    setState(() {
      pizza = category == "Pizza";
      icecream = category == "Ice-cream";
      salad = category == "Salad";
      burger = category == "Burger";
    });
    foodItemStream = DatabaseMethods().getFoodItemByCategory(category);
  }

  void _deleteItem(DocumentReference documentReference) async {
    try {
      await documentReference.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Sản phẩm đã được xoá!",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Lỗi khi xoá sản phẩm!",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xFF373866),
          ),
        ),
        centerTitle: true,
        title: Text(
          "See Food",
          style: AppWidget.HeadlinextFieldStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10.0, left: 20.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: showItem(),
              ),
              const SizedBox(
                height: 20.0,
              ),
              allItemsVertical()
            ],
          ),
        ),
      ),
    );
  }
}
