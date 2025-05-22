import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  Map<String, dynamic> users = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/users'));

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to load user data'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        padding: EdgeInsets.all(16),
        children: users.entries.map((entry) {
          String id = entry.key;
          List<dynamic> details = entry.value;

          return Card(
            margin: EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User ID: $id', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...details.map((info) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ${info['name'] ?? 'null'}'),
                          Text("Parent's Phone: ${info["parent's phone"] ?? 'null'}"),
                          Text('Phone Number: ${info['phonenumber'] ?? 'null'}'),
                          Text('Address: ${info['address'] ?? 'null'}'),
                          Text('Details: ${info['details'] ?? 'null'}'),
                        ],
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
