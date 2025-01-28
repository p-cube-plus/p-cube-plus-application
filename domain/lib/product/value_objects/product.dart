class Product {
  final String name;
  final String typeName; // 도서, etc
  final String location; // 책상1-책장2-A1

  const Product({
    required this.name,
    required this.typeName,
    required this.location,
  });
}

class RentedProduct extends Product {
  final String rentUserName;
  final DateTime rentStartDate;
  final DateTime rentEndDate;

  const RentedProduct({
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
  const RentableProduct({
    required super.name,
    required super.typeName,
    required super.location,
  });
}
