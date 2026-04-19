import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/bill.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Bill> getBillsForDay(DateTime day) {
    return bills.where((b) {
      try {
        DateTime billDate = DateTime.parse(b.dueDate);
        return billDate.year == day.year &&
            billDate.month == day.month &&
            billDate.day == day.day;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedBills =
    _selectedDay == null ? [] : getBillsForDay(_selectedDay!);

    return Scaffold(
      appBar: AppBar(title: Text("Calendar")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },

            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                final dayBills = getBillsForDay(date);
                if (dayBills.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),

          SizedBox(height: 10),

          Expanded(
            child: selectedBills.isEmpty
                ? Center(child: Text("No bills for this day"))
                : ListView.builder(
              itemCount: selectedBills.length,
              itemBuilder: (context, index) {
                final bill = selectedBills[index];
                return Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(bill.name),
                    subtitle: Text("৳${bill.amount}"),
                    trailing: Text(
                      bill.isPaid ? "Paid" : "Unpaid",
                      style: TextStyle(
                        color: bill.isPaid
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}