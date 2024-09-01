class UserProjectData {
  final int id;
  final String name;
  final String type;
  final String status;
  final DateTime startDate;
  final DateTime? endDate;
  final String? graphic;
  final List<String> platform;
  final bool isFindingMember;
  final bool isAbleInquiry;

  UserProjectData({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.graphic,
    required this.platform,
    required this.isFindingMember,
    required this.isAbleInquiry,
  });
}
