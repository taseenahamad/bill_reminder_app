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
  String statusFilter = "All";
  String categoryFilter = "All";

  List<String> get categories {
    final cats = bills.map((b) => b.category).toSet().toList();
    return ["All", ...cats];
  }

  List<Bill> get filteredBills {
    return bills.where((b) {
      // Status filter
      if (statusFilter == "Paid" && !b.isPaid) return false;
      if (statusFilter == "Unpaid" && b.isPaid) return false;

      // Category filter
      if (categoryFilter != "All" && b.category != categoryFilter) {
        return false;
      }

      return true;
    }).toList();
  }

  double get total =>
      bills.fold(0, (sum, item) => sum + item.amount);

  double get paid =>
      bills.where((b) => b.isPaid).fold(0, (s, b) => s + b.amount);

  double get unpaid =>
      bills.where((b) => !b.isPaid).fold(0, (s, b) => s + b.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Dashboard")),

      body: Column(
        children: [
          // ===== HEADER =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello 👋", style: TextStyle(fontSize: 18)),
                    Text("Manage your bills",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                CircleAvatar(child: Icon(Icons.person)),
              ],
            ),
          ),

          // ===== SUMMARY CARDS =====
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCard("Total", total, Colors.indigo),
                _buildCard("Paid", paid, Colors.green),
                _buildCard("Unpaid", unpaid, Colors.red),
              ],
            ),
          ),

          SizedBox(height: 10),

          // ===== FILTER SECTION =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                // Status filter chips
                Row(
                  children: ["All", "Paid", "Unpaid"].map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(status),
                        selected: statusFilter == status,
                        onSelected: (_) {
                          setState(() {
                            statusFilter = status;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 10),

                // Category dropdown
                DropdownButtonFormField(
                  value: categoryFilter,
                  items: categories
                      .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      categoryFilter = val.toString();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Filter by Category",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // ===== BILL LIST =====
          Expanded(
            child: filteredBills.isEmpty
                ? Center(child: Text("No bills found"))
                : ListView.builder(
              itemCount: filteredBills.length,
              itemBuilder: (context, i) {
                final b = filteredBills[i];

                return Dismissible(
                  key: Key(b.name + i.toString()),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (dir) {
                    setState(() {
                      if (dir ==
                          DismissDirection.startToEnd) {
                        b.isPaid = true;
                      } else {
                        bills.remove(b);
                      }
                    });
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: b.isPaid
                            ? Colors.green
                            : Colors.orange,
                        child: Icon(
                          b.isPaid
                              ? Icons.check
                              : Icons.warning,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(b.name),
                      subtitle: Text(
                          "${b.category} • Due: ${b.dueDate}"),
                      trailing: Text(
                        "৳${b.amount}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BillDetailsPage(bill: b),
                          ),
                        );
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddBillPage()),
          );
          setState(() {});
        },
      ),
    );
  }

  // ===== CARD UI =====
  Widget _buildCard(String title, double value, Color color) {
    return Container(
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Text(title),
              SizedBox(height: 6),
              Text(
                "৳${value.toStringAsFixed(0)}",
                style: TextStyle(
                    fontSize: 18,
                    color: color,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
