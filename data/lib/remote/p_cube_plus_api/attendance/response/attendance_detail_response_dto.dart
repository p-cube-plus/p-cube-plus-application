class AttendanceDetailResponseDTO {
  String category;
  List<RecordListDTO> recordList;
  AttendanceDetailResponseDTO({
    required this.category,
    required this.recordList,
  });

  factory AttendanceDetailResponseDTO.fromJson(Map<String, dynamic> map) {
    return AttendanceDetailResponseDTO(
      category: map['category'] as String,
      recordList: List<RecordListDTO>.from(
        (map['record_list'] as List<int>).map<RecordListDTO>(
          (x) => RecordListDTO.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class RecordListDTO {
  String date;
  int weekOfMonth;
  String state;
  RecordListDTO({
    required this.date,
    required this.weekOfMonth,
    required this.state,
  });

  factory RecordListDTO.fromJson(Map<String, dynamic> map) {
    return RecordListDTO(
      date: map['date'] as String,
      weekOfMonth: map['weekOfMonth'] as int,
      state: map['state'] as String,
    );
  }
}
