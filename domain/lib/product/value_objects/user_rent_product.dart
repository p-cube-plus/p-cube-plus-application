class UserRentProduct {
  final String name;
  final DateTime rentStartDate;
  final DateTime rentEndDate;
  const UserRentProduct({
    required this.name,
    required this.rentStartDate,
    required this.rentEndDate,
  });

  int get dDay => rentEndDate.difference(DateTime.now()).inDays;
}
