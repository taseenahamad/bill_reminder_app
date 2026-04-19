import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/bill.dart';

class AnalyticsPage extends StatelessWidget {
  double get total => bills.fold(0, (s, b) => s + b.amount);

  double get paid =>
      bills.where((b) => b.isPaid).fold(0, (s, b) => s + b.amount);

  double get unpaid =>
      bills.where((b) => !b.isPaid).fold(0, (s, b) => s + b.amount);

  Map<String, double> get categoryTotals {
    Map<String, double> data = {};
    for (var b in bills) {
      data[b.category] = (data[b.category] ?? 0) + b.amount;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final categories = categoryTotals;

    return Scaffold(
      appBar: AppBar(title: Text("Analytics")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== SUMMARY CARDS =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCard("Total", total, Colors.indigo),
                _buildCard("Paid", paid, Colors.green),
                _buildCard("Unpaid", unpaid, Colors.red),
              ],
            ),

            SizedBox(height: 20),

            // ===== PIE CHART =====
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Spending by Category",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: categories.entries.map((entry) {
                          final value = entry.value;
                          return PieChartSectionData(
                            value: value,
                            title: entry.key,
                            radius: 60,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // ===== BAR CHART =====
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Category Comparison",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        barGroups: _buildBarGroups(categories),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== CARD UI =====
  Widget _buildCard(String title, double value, Color color) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title),
            Text("৳${value.toStringAsFixed(0)}",
                style: TextStyle(fontSize: 18, color: color)),
          ],
        ),
      ),
    );
  }

  // ===== BAR CHART DATA =====
  List<BarChartGroupData> _buildBarGroups(Map<String, double> data) {
    int index = 0;
    return data.entries.map((entry) {
      return BarChartGroupData(
        x: index++,
        barRods: [
          BarChartRodData(
            toY: entry.value,
            width: 16,
          ),
        ],
      );
    }).toList();
  }
}