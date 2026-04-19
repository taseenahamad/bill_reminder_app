import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Your Name";
  String email = "your@email.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== PROFILE IMAGE =====
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),

            SizedBox(height: 16),

            // ===== NAME =====
            Text(
              name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 6),

            // ===== EMAIL =====
            Text(
              email,
              style: TextStyle(color: Colors.grey[600]),
            ),

            SizedBox(height: 30),

            // ===== OPTIONS =====
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text("Edit Profile"),
                    onTap: () {
                      _editProfile(context);
                    },
                  ),
                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text("Change Password"),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Feature coming soon")),
                      );
                    },
                  ),
                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text("Logout"),
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== EDIT PROFILE DIALOG =====
  void _editProfile(BuildContext context) {
    TextEditingController nameController =
    TextEditingController(text: name);
    TextEditingController emailController =
    TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text("Save"),
            onPressed: () {
              setState(() {
                name = nameController.text;
                email = emailController.text;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // ===== LOGOUT CONFIRMATION =====
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text("Logout"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Logged out")),
              );
            },
          ),
        ],
      ),
    );
  }
}