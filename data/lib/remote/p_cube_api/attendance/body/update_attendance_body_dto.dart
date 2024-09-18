class UpdateAttendanceBodyDTO {
  String? state;
  String? firstAuthTIme;
  String? secondAuthTime;
  UpdateAttendanceBodyDTO({
    this.state,
    this.firstAuthTIme,
    this.secondAuthTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'firstAuthTIme': firstAuthTIme,
      'secondAuthTime': secondAuthTime,
    };
  }
}
