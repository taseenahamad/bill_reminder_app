class Bill {
  String name;
  double amount;
  String dueDate;
  String category;
  bool isPaid;

  Bill({
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.category,
    this.isPaid = false,
  });
}

List<Bill> bills = [];