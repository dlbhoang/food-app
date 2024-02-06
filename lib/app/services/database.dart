
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }
  
  // ignore: non_constant_identifier_names
  UpdateUserWallet(String id, String amout) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({"Wallet": amout});
  }

  // ignore: non_constant_identifier_names
  Future<Stream<QuerySnapshot>> getFoodItem(String name) async{
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodItem(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

  Future addFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id).collection("Cart").add(userInfoMap);
  }
 Future<Stream<QuerySnapshot>> getFoodCart(String id) async{
    return await FirebaseFirestore.instance.collection('users').doc(id).collection('Cart').snapshots();
  } 

  UpdateUserwallet(String id, String amount) async{
    return await FirebaseFirestore.instance.collection('users').doc(id).update({"Wallet":amount});
  }
}
