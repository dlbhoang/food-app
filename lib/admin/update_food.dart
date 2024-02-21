// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/app/utils/app_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateFoodItem extends StatefulWidget {
  final String foodItemId;

  const UpdateFoodItem({super.key, required this.foodItemId});

  @override
  _UpdateFoodItemState createState() => _UpdateFoodItemState();
}

class _UpdateFoodItemState extends State<UpdateFoodItem> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
    final List<String> fooditems = ['Ice-cream', 'Burger', 'Salad', 'Pizza', 'New Category'];
  File? selectedImage;
  String? value;

  @override
  void initState() {
    super.initState();
    _loadFoodItemDetails();
  }

  void _loadFoodItemDetails() async {
    DocumentSnapshot foodItemSnapshot =
        await FirebaseFirestore.instance.collection("foods").doc(widget.foodItemId).get();
    if (foodItemSnapshot.exists) {
      setState(() {
        nameController.text = foodItemSnapshot["Name"];
        priceController.text = foodItemSnapshot["Price"];
        detailController.text = foodItemSnapshot["Detail"];
        value = foodItemSnapshot["Category"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Food Item"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Item Picture",
                style: AppWidget.SemiBoldTextFieldStyle(),
              ),
              const SizedBox(height: 20.0),
              selectedImage == null
                  ? GestureDetector(
                      onTap: getImage,
                      child: Center(
                        child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 30.0),
              Text(
                "Item Name",
                style: AppWidget.SemiBoldTextFieldStyle(),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Name",
                    hintStyle: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Text(
                "Item Price",
                style: AppWidget.SemiBoldTextFieldStyle(),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Price",
                    hintStyle: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Text(
                "Item Detail",
                style: AppWidget.SemiBoldTextFieldStyle(),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  maxLines: 6,
                  controller: detailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Detail",
                    hintStyle: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Select Category",
                style: AppWidget.SemiBoldTextFieldStyle(),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: fooditems.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                      this.value = value;
                    }),
                    dropdownColor: Colors.white,
                    hint: const Text("Select Category"),
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              GestureDetector(
                onTap: uploadItem,
                child: Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  Future<void> uploadItem() async {
    if (selectedImage != null &&
        nameController.text != "" &&
        priceController.text != "" &&
        detailController.text != "" &&
        value != null) {
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("foodImages").child(widget.foodItemId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> updateItem = {
        "Image": downloadUrl,
        "Name": nameController.text,
        "Price": priceController.text,
        "Detail": detailController.text,
        "Category": value
      };

      try {
        await FirebaseFirestore.instance.collection("foods").doc(widget.foodItemId).update(updateItem);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Food Item has been updated Successfully",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Error updating food item",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      }
    }
  }
}
