// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../../services/database.dart';
import '../../services/shared_prefences.dart';
import '../../utils/app_widget.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id, wallet, email;
  int total = 0, amount2 = 0;

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      amount2 = total;
      setState(() {});
    });
  }

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    foodStream = await DatabaseMethods().getFoodCart(id!);
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? foodStream;

 confirmOrderButtonPressed() async {
  String subject = 'Order Confirmation';
  String body = 'Your order has been confirmed!\n\n';

  // Lấy danh sách các món hàng trong giỏ hàng
  QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(id!)
      .collection('Cart')
      .get();

  // Khởi tạo danh sách các món hàng để lưu vào đơn hàng
  List<Map<String, dynamic>> orderItems = [];

  // Lặp qua từng món hàng trong giỏ hàng để giảm số lượng và cập nhật đơn hàng
  cartSnapshot.docs.forEach((doc) async {
    String foodName = doc['Name'];
    String price = doc['Total'];
    String quantity = doc['Quantity'];
    String totalPerFood = price;

    body += '$foodName: \$$price x $quantity = \$$totalPerFood\n';

    int currentQuantity = int.parse(quantity);

    // Giảm số lượng của món hàng
    int newQuantity = currentQuantity - 1;
    if (newQuantity <= 0) {
      // Nếu số lượng giảm xuống dưới 0, xóa món hàng khỏi giỏ hàng
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id!)
          .collection('Cart')
          .doc(doc.id)
          .delete();
    } else {
      // Ngược lại, cập nhật lại số lượng của món hàng
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id!)
          .collection('Cart')
          .doc(doc.id)
          .update({'Quantity': newQuantity.toString()});
    }

    orderItems.add({
      'foodName': foodName,
      'price': price,
      'quantity': quantity,
    });
  });

  DocumentReference orderRef = FirebaseFirestore.instance.collection('orders').doc();

  await orderRef.set({
    'userId': id!,
    'orderItems': orderItems,
    'totalPrice': total,
    'createdAt': Timestamp.now(), 
  });

  body += '\nTotal: \$${total.toString()}\nIndex: ${amount2.toString()}';

  await sendEmail(email!, subject, body);

  await SharedPreferenceHelper().saveUserPurchaseConfirmed(false);

  await DatabaseMethods().updateFoodCartToPaid(id!); 

  await DatabaseMethods().clearUserCart(id!); 

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Order confirmation email sent successfully!",
        style: TextStyle(fontSize: 18.0),
      ),
    ),
  );
}




  sendEmail(String userEmail, String subject, String body) async {
    String username = 'danglebaohoang0603.01@gmail.com';
    String password = 'ginm awln vzdl azui';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username)
      ..recipients.add(userEmail)
      ..subject = subject
      ..text = body;

    try {
      // ignore: unused_local_variable
      final sendReport = await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Email sent successfully!",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } on MailerException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Failed to send email: ${e.toString()}",
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }

  Widget foodCart() {
  return StreamBuilder(
    stream: foodStream,
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error loading data'));
      } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
        return const Center(child: Text('No data available'));
      } else {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            total = total + int.parse(ds["Total"]);
            return Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 10.0,
              ),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text(ds["Quantity"])),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          ds["Image"],
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        children: [
                          Text(
                            ds["Name"],
                            style: AppWidget.SemiBoldTextFieldStyle(),
                          ),
                          Text(
                            "\$" + ds["Total"],
                            style: AppWidget.SemiBoldTextFieldStyle(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Text(
                    "Food Cart",
                    style: AppWidget.HeadlinextFieldStyle(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: foodCart(),
            ),
            const Spacer(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Text(
                    "\$$total",
                    style: AppWidget.SemiBoldTextFieldStyle(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: confirmOrderButtonPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: const Center(
                  child: Text(
                    "Confirm Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
