class Product {
  final String name;
  final String typeName; // 도서, etc
  final String location; // 책상1-책장2-A1

  Product({
    required this.name,
    required this.typeName,
    required this.location,
  });
}

class RentedProduct extends Product {
  String rentUserName;
  DateTime rentStartDate;
  DateTime rentEndDate;

  RentedProduct({
    required super.name,
    required super.typeName,
    required super.location,
    required this.rentUserName,
    required this.rentStartDate,
    required this.rentEndDate,
  });

  bool get isRentExpired => rentEndDate.difference(DateTime.now()).inDays <= 0;
}

class RentableProduct extends Product {
  RentableProduct({
    required super.name,
    required super.typeName,
    required super.location,
  });
}
