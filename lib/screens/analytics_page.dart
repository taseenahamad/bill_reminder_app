import 'package:flutter/material.dart';
import '../models/bill.dart';

class AnalyticsPage extends StatelessWidget {
  double get total => bills.fold(0, (s, b) => s + b.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analytics")),
      body: Center(child: Text("Total: ৳${total.toStringAsFixed(0)}")),
    );
  }
}