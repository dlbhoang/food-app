import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await _firestore.collection('users').doc(id).set(userInfoMap);
  }
 Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
      throw Exception('Error deleting user');
    }
  }
  Future updateUserWallet(String id, String amout) async {
    return await _firestore
        .collection('users')
        .doc(id)
        .update({"Wallet": amout});
  }

 Stream<QuerySnapshot> getAllFoodItems() {
    return FirebaseFirestore.instance.collection('foods').snapshots();
  }

  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return _firestore.collection(name).snapshots();
  }

  Future addFoodItem(Map<String, dynamic> userInfoMap, String name) async {
    return await _firestore.collection(name).add(userInfoMap);
  }

  Future addFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
    return await _firestore
        .collection('users')
        .doc(id)
        .collection("Cart")
        .add(userInfoMap);
  }
 Stream<QuerySnapshot> getFoodItemByCategory(String category) {
    return FirebaseFirestore.instance
        .collection("foods")
        .where("Category", isEqualTo: category)
        .snapshots();
  }

   Future<DocumentSnapshot> getFoodItemById(String foodItemId) {
    return FirebaseFirestore.instance
        .collection("foods")
        .doc(foodItemId)
        .get();
  }

  Future<void> updateFoodItem(String foodItemId, Map<String, dynamic> updatedData) {
    return FirebaseFirestore.instance
        .collection("foods")
        .doc(foodItemId)
        .update(updatedData);
  }
  
  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return _firestore
        .collection('users')
        .doc(id)
        .collection('Cart')
        .snapshots();
  }

  Future updateFoodCartToPaid(String userId) async {
    QuerySnapshot<Map<String, dynamic>> cartSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('Cart')
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> cartDocs =
        cartSnapshot.docs;

    for (var doc in cartDocs) {
      if (doc.data().containsKey('Paid')) {
        await doc.reference.update({'Paid': true});
      } else {
        print('Field "Paid" does not exist in the document.');
      }
    }
  }

  Future<void> updateFoodItemQuantity(String id, String quantity) async {
    try {
      await _firestore
          .collection('foods')
          .doc(id)
          .update({'Quantity': quantity});
    } catch (e) {
      print('Error updating food item quantity: $e');
      throw Exception('Error updating food item quantity');
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFoodItemByName(String name) async {
    try {
      // Query the collection 'foods' for documents where the 'Name' field matches the provided name
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('foods')
          .where('Name', isEqualTo: name)
          .get();

      return querySnapshot;
    } catch (e) {
      print('Error fetching food items by name: $e');
      throw Exception('Error fetching food items by name');
    }
  }
  Future<void> updateUserOrderConfirmation(
      String userId, bool confirmed) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'OrderConfirmed': confirmed});
  }

  Future<void> clearUserCart(String userId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Cart')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

 Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
  try {
    return _firestore
        .collection('users')
        .snapshots();
  } catch (e) {
    print('Error fetching all users: $e');
    throw Exception('Error fetching all users');
  }
}

}
