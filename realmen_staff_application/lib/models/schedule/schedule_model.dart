class SchedulesModel {
  List<ScheduleModel>? scheduleModel;

  SchedulesModel({this.scheduleModel});

  factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      scheduleModel: json['values'] != null
          ? (json['values'] as List)
              ?.map((e) => ScheduleModel.fromJson(e))
              ?.toList()
          : null,
    );
  }

  List<Map<String, dynamic>> toJson() {
    return scheduleModel!.map((schedule) => schedule.toJson()).toList();
  }
}

class ScheduleModel {
  int? shiftId;
  int? scheduleId;
  int? staffId;
  String? shift;
  String? workingDate;
  String? start;
  String? end;
  String? scheduleStatus;

  ScheduleModel({
    this.shiftId,
    this.scheduleId,
    this.staffId,
    this.shift,
    this.workingDate,
    this.start,
    this.end,
    this.scheduleStatus,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'],
      staffId: json['staffId'],
      shift: json['shift'],
      workingDate: json['workingDate'],
      start: json['start'],
      end: json['end'],
      scheduleStatus: json['scheduleStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shiftId': shiftId,
      'workingDate': workingDate,
    };
  }
}
