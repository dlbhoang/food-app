import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/app/services/database.dart';
import 'package:food_app/app/utils/app_widget.dart';

class SeeUser extends StatefulWidget {
  const SeeUser({Key? key}) : super(key: key);

  @override
  _SeeUserState createState() => _SeeUserState();
}

class _SeeUserState extends State<SeeUser> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> userStream;

  @override
  void initState() {
    super.initState();
    _loadAllUsers();
  }

  void _loadAllUsers() {
    userStream = DatabaseMethods().getAllUsers();
  }

  void _deleteUser(String userId) {
    DatabaseMethods().deleteUser(userId);
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No users found'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot<Map<String, dynamic>> ds =
                  snapshot.data!.docs[index];
              return ListTile(
                title: Text(
                  ds['Name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  ds['Email'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete User"),
                          content: const Text("Are you sure you want to delete this user?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteUser(ds.id);
                                Navigator.pop(context);
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
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
      appBar: AppBar(
        title: Text(
          'See User',
          style: AppWidget.HeadlinextFieldStyle(),
        ),
      ),
      body: _buildUserList(),
    );
  }
}
