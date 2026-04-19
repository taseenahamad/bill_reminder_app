import 'package:flutter/material.dart';
import '../models/bill.dart';

class AddBillPage extends StatefulWidget {
  @override
  _AddBillPageState createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  double amount = 0;
  String category = 'Electricity';
  DateTime? selectedDate;

  final List<String> categories = [
    'Electricity',
    'Internet',
    'Rent',
    'Subscription',
    'Water',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Bill")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ===== BILL NAME =====
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Bill Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter bill name" : null,
                  onSaved: (value) => name = value!,
                ),

                SizedBox(height: 16),

                // ===== AMOUNT =====
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Amount",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter amount";
                    }
                    if (double.tryParse(value) == null) {
                      return "Enter valid number";
                    }
                    return null;
                  },
                  onSaved: (value) => amount = double.parse(value!),
                ),

                SizedBox(height: 16),

                // ===== CATEGORY =====
                DropdownButtonFormField(
                  value: category,
                  items: categories
                      .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => category = value.toString());
                  },
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 16),

                // ===== DATE PICKER =====
                InkWell(
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );

                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Due Date",
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      selectedDate == null
                          ? "Select date"
                          : "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // ===== SAVE BUTTON =====
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Save Bill"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select a date")),
                          );
                          return;
                        }

                        _formKey.currentState!.save();

                        bills.add(
                          Bill(
                            name: name,
                            amount: amount,
                            dueDate:
                            "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                            category: category,
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}