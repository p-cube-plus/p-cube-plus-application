class ProductDetail {
  final DateTime rentStartDate;
  final DateTime rentEndDate;
  final String? rentUserName;
  final Map<String, List<(String key, String name)>> detailInfoMap;

  ProductDetail({
    required this.rentStartDate,
    required this.rentEndDate,
    this.rentUserName,
    required this.detailInfoMap,
  });

  int get dDay => rentEndDate.difference(DateTime.now()).inDays;
}
