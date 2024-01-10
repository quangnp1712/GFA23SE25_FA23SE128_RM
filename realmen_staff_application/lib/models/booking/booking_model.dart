class BookingModel {
  // To json
  String? appointmentDate;
  int? branchId;
  int? accountId;
  List<BookingServiceModel>? bookingServices;

  // From Json
  List<BookingContent>? content;
  int? totalElements;
  int? totalPages;
  int? pageSize;
  int? current;

  BookingModel({
    // To json
    this.appointmentDate,
    this.branchId,
    this.accountId,
    this.bookingServices,

    // From Json
    this.content,
    this.totalElements,
    this.totalPages,
    this.pageSize,
    this.current,
  });

  Map<String, dynamic> toJson() {
    return {
      'appointmentDate': appointmentDate,
      'branchId': branchId,
      'accountId': accountId,
      'bookingServices': bookingServices != null
          ? bookingServices!.map((service) => service.toJson()).toList()
          : [],
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      content: json['content'] != null
          ? (json['content'] as List)
              .map((e) => BookingContent.fromJson(e))
              .toList()
          : null,
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      pageSize: json['pageSize'],
      current: json['current'],
    );
  }
}

class BookingContent {
  int? bookingId;
  int? accountId;
  int? branchId;
  String? bookingCode;
  String? bookingOwnerName;
  String? bookingOwnerPhone;
  String? branchAddress;
  String? branchName;
  String? appointmentDate;
  List<BookingServiceModel>? bookingServices;
  String? bookingStatus;

  BookingContent({
    this.bookingId,
    this.accountId,
    this.branchId,
    this.bookingCode,
    this.bookingOwnerName,
    this.bookingOwnerPhone,
    this.branchAddress,
    this.branchName,
    this.appointmentDate,
    this.bookingServices,
    this.bookingStatus,
  });

  factory BookingContent.fromJson(Map<String, dynamic> json) {
    return BookingContent(
      bookingId: json['bookingId'],
      accountId: json['accountId'],
      branchId: json['branchId'],
      bookingCode: json['bookingCode'],
      bookingOwnerName: json['bookingOwnerName'],
      bookingOwnerPhone: json['bookingOwnerPhone'],
      branchAddress: json['branchAddress'],
      branchName: json['branchName'],
      appointmentDate: json['appointmentDate'],
      bookingServices: json['bookingServices'] != null
          ? ((json['bookingServices'] as List)
              .map((e) => BookingServiceModel.fromJson(e))
              .toList())
          : null,
      bookingStatus: json['bookingStatus'],
    );
  }
}

class BookingServiceModel {
  int? bookingServiceId;
  int? bookingId;
  int? serviceId;
  int? staffId;
  String? serviceName;
  int? servicePrice;
  String? staffName;
  String? staffPhone;
  String? startAppointment;
  String? actualStartTime;
  String? endAppointment;
  String? actualEndTime;
  String? duration;
  String? durationText;
  String? bookingServiceStatus;
  String? professional;
  bool? allowUpdate;

  BookingServiceModel({
    this.bookingServiceId,
    this.bookingId,
    this.serviceId,
    this.staffId,
    this.serviceName,
    this.servicePrice,
    this.staffName,
    this.staffPhone,
    this.startAppointment,
    this.actualStartTime,
    this.endAppointment,
    this.actualEndTime,
    this.duration,
    this.durationText,
    this.bookingServiceStatus,
    this.professional,
    this.allowUpdate,
  });

  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'staffId': staffId,
      'startAppointment': startAppointment,
      'endAppointment': endAppointment,
    };
  }

  factory BookingServiceModel.fromJson(Map<String, dynamic> json) {
    return BookingServiceModel(
      bookingServiceId: json['bookingServiceId'],
      bookingId: json['bookingId'],
      serviceId: json['serviceId'],
      staffId: json['staffId'],
      serviceName: json['serviceName'],
      servicePrice: json['servicePrice'],
      staffName: json['staffName'],
      staffPhone: json['staffPhone'],
      startAppointment: json['startAppointment'],
      actualStartTime: json['actualStartTime'],
      endAppointment: json['endAppointment'],
      actualEndTime: json['actualEndTime'],
      duration: json['duration'],
      durationText: json['durationText'],
      bookingServiceStatus: json['bookingServiceStatus'],
      professional: json['professional'],
      allowUpdate: json['allowUpdate'],
    );
  }
}
