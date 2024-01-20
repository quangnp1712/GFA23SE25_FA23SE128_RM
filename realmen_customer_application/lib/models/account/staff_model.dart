// ignore_for_file: unnecessary_null_in_if_null_operators

class StaffModel {
  int? staffId;
  int? accountId;
  double? averageRating;
  List<ScheduleModel>? scheduleList;
  String? professional;
  List<BookingAppointmentModel>? bookingList;

  StaffModel({
    this.staffId,
    this.accountId,
    this.averageRating,
    this.scheduleList,
    this.professional,
    this.bookingList,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      accountId: json['accountId'],
      staffId: json['staffId'] ?? null,
      averageRating:
          json['averageRating'] == "NaN" ? null : json['averageRating'],
      scheduleList: json['scheduleList'] != null && json['scheduleList'] != []
          ? (json['scheduleList'] as List)
              .map((item) => ScheduleModel.fromJson(item))
              .toList()
          : null,
      professional: json['professional'] ?? null,
      bookingList: json['bookingList'] != null && json['bookingList'] != []
          ? (json['bookingList'] as List)
              .map((item) => BookingAppointmentModel.fromJson(item))
              .toList()
          : null,
    );
  }
}

class ScheduleModel {
  int? scheduleId;
  int? staffId;
  int? shiftId;
  String? shift;
  String? workingDate;
  String? startShift;
  String? endShift;
  String? scheduleStatus;

  ScheduleModel({
    this.scheduleId,
    this.staffId,
    this.shiftId,
    this.shift,
    this.workingDate,
    this.startShift,
    this.endShift,
    this.scheduleStatus,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'] ?? null,
      staffId: json['staffId'] ?? null,
      shiftId: json['shiftId'] ?? null,
      shift: json['shift'] ?? null,
      workingDate: json['workingDate'] ?? null,
      startShift: json['startShift'] ?? null,
      endShift: json['endShift'] ?? null,
      scheduleStatus: json['scheduleStatus'] ?? null,
    );
  }
}

class BookingAppointmentModel {
  int? bookingId;
  int? bookingServiceId;
  String? appointmentDate;
  String? startAppointment;
  String? endAppointment;
  String? bookingServiceStatus;

  BookingAppointmentModel({
    this.bookingId,
    this.bookingServiceId,
    this.appointmentDate,
    this.startAppointment,
    this.endAppointment,
    this.bookingServiceStatus,
  });

  factory BookingAppointmentModel.fromJson(Map<String, dynamic> json) {
    return BookingAppointmentModel(
      bookingId: json['bookingId'],
      bookingServiceId: json['bookingServiceId'],
      appointmentDate: json['appointmentDate'],
      startAppointment: json['startAppointment'],
      endAppointment: json['endAppointment'],
      bookingServiceStatus: json['bookingServiceStatus'],
    );
  }
}
