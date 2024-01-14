class TimeSlotModel {
  int? timeSlotId;
  int? shiftId;
  String? time;
  String? timeText;
  bool? isAvailable;

  TimeSlotModel({
    this.timeSlotId,
    this.shiftId,
    this.time,
    this.timeText,
    this.isAvailable,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      timeSlotId: json['timeSlotId'],
      shiftId: json['shiftId'],
      time: json['time'],
      timeText: json['timeText'],
      isAvailable: json['isAvailable'],
    );
  }
}
