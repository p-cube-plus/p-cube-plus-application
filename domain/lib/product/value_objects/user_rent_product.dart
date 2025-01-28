class UserRentProduct {
  final String name;
  final DateTime rentStartDate;
  final DateTime rendEndDate;
  const UserRentProduct({
    required this.name,
    required this.rentStartDate,
    required this.rendEndDate,
  });

  int get dDay => rendEndDate.difference(DateTime.now()).inDays;
}
