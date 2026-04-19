import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/calendar_page.dart';
import '../screens/analytics_page.dart';
import '../screens/settings_page.dart';
import '../screens/profile_page.dart'; // ✅ important

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ===== PROFILE HEADER (CLICKABLE) =====
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
            },
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 30, color: Colors.indigo),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your Name",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "Tap to view profile",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),

          // ===== MENU ITEMS =====
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text("Calendar"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => CalendarPage()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text("Analytics"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => AnalyticsPage()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SettingsPage()),
              );
            },
          ),

          Divider(),

          // ===== ABOUT =====
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("About"),
                  content: Text(
                    "Bill Reminder App v1.0\nBuilt with Flutter",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}