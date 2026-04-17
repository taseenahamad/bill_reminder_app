import 'package:flutter/material.dart';
import '../models/bill.dart';

class BillDetailsPage extends StatelessWidget {
  final Bill bill;

  BillDetailsPage({required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Column(
        children: [
          Text(bill.name),
          Text("৳${bill.amount}"),
          ElevatedButton(
            child: Text("Mark Paid"),
            onPressed: () {
              bill.isPaid = true;
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}