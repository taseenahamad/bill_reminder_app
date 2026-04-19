import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool darkMode = false;
  bool appLock = false;

  String selectedCurrency = "BDT";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          // ===== GENERAL =====
          _sectionTitle("General"),

          SwitchListTile(
            title: Text("Enable Notifications"),
            subtitle: Text("Get reminders for upcoming bills"),
            value: notificationsEnabled,
            onChanged: (val) {
              setState(() => notificationsEnabled = val);
            },
          ),

          SwitchListTile(
            title: Text("Dark Mode"),
            subtitle: Text("Switch app theme"),
            value: darkMode,
            onChanged: (val) {
              setState(() => darkMode = val);
            },
          ),

          ListTile(
            title: Text("Currency"),
            subtitle: Text(selectedCurrency),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _selectCurrency(context),
          ),

          Divider(),

          // ===== SECURITY =====
          _sectionTitle("Security"),

          SwitchListTile(
            title: Text("App Lock"),
            subtitle: Text("Enable PIN/Fingerprint (UI only)"),
            value: appLock,
            onChanged: (val) {
              setState(() => appLock = val);
            },
          ),

          Divider(),

          // ===== ABOUT =====
          _sectionTitle("About"),

          ListTile(
            leading: Icon(Icons.info),
            title: Text("App Version"),
            subtitle: Text("1.0.0"),
          ),

          ListTile(
            leading: Icon(Icons.code),
            title: Text("Developer"),
            subtitle: Text("Your Name"),
          ),

          ListTile(
            leading: Icon(Icons.description),
            title: Text("About App"),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("About"),
                  content: Text(
                    "Bill Reminder App\n\nTrack your bills, avoid late fees, and manage expenses easily.",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ===== Section Title Widget =====
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  // ===== Currency Picker Dialog =====
  void _selectCurrency(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: ["BDT", "USD", "EUR"].map((currency) {
            return ListTile(
              title: Text(currency),
              onTap: () {
                setState(() => selectedCurrency = currency);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }
}