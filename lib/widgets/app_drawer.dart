import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/calendar_page.dart';
import '../screens/analytics_page.dart';
import '../screens/settings_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.account_circle, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text("Bill Reminder", style: TextStyle(color: Colors.white, fontSize: 20)),
                Text("Manage your bills easily", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
            },
          ),

          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text("Calendar"),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CalendarPage()));
            },
          ),

          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text("Analytics"),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AnalyticsPage()));
            },
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("About"),
                    content: Text("Bill Reminder App v1.0\nBuilt with Flutter"),
                    ),
                  );
              },
          ),
        ],
      ),
    );
  }
}