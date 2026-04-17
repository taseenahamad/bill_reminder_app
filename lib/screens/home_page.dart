import 'package:flutter/material.dart';
import '../models/bill.dart';
import 'add_bill_page.dart';
import 'details_page.dart';
import '../widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double get totalDue => bills.where((b) => !b.isPaid).fold(0, (s, b) => s + b.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Home")),
      body: Column(
        children: [
          Text("Total Due: ৳${totalDue.toStringAsFixed(0)}"),
          Expanded(
            child: ListView.builder(
              itemCount: bills.length,
              itemBuilder: (context, i) {
                final b = bills[i];
                return ListTile(
                  title: Text(b.name),
                  subtitle: Text(b.dueDate),
                  trailing: Text("৳${b.amount}"),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BillDetailsPage(bill: b))),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => AddBillPage()));
          setState(() {});
        },
      ),
    );
  }
}
