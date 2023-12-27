// ignore_for_file: unnecessary_null_in_if_null_operators

class StaffModel {
  int? staffId;
  int? accountId;
  double? averageRating;
  List<ScheduleModel>? scheduleList;
  String? professional;

  StaffModel({
    this.staffId,
    this.accountId,
    this.averageRating,
    this.scheduleList,
    this.professional,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      accountId: json['accountId'],
      staffId: json['staffId'] ?? null,
      averageRating: json['averageRating'] ?? null,
      scheduleList: json['scheduleList'] != null && json['scheduleList'] != []
          ? (json['scheduleList'] as List)
              .map((item) => ScheduleModel.fromJson(item))
              .toList()
          : null,
      professional: json['professional'] ?? null,
    );
  }
}

class ScheduleModel {
  int? scheduleId;
  int? staffId;
  int? shiftId;
  String? shift;
  String? workingDate;
  String? start;
  String? end;
  String? scheduleStatus;

  ScheduleModel({
    this.scheduleId,
    this.staffId,
    this.shiftId,
    this.shift,
    this.workingDate,
    this.start,
    this.end,
    this.scheduleStatus,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'] ?? null,
      staffId: json['staffId'] ?? null,
      shiftId: json['shiftId'] ?? null,
      shift: json['shift'] ?? null,
      workingDate: json['workingDate'] ?? null,
      start: json['start'] ?? null,
      end: json['end'] ?? null,
      scheduleStatus: json['scheduleStatus'] ?? null,
    );
  }
}
