import 'package:flutter/material.dart';
import '../models/bill.dart';

class AddBillPage extends StatefulWidget {
  @override
  _AddBillPageState createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  String name = '';
  String date = '';
  String category = 'General';
  double amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Bill")),
      body: Column(
        children: [
          TextField(onChanged: (v) => name = v),
          TextField(onChanged: (v) => amount = double.tryParse(v) ?? 0),
          TextField(onChanged: (v) => date = v),
          ElevatedButton(
            child: Text("Save"),
            onPressed: () {
              bills.add(Bill(name: name, amount: amount, dueDate: date, category: category));
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
