class RatingModel {
  // to json
  int? staffId;
  int? bookingServiceId;
  double? point;
  String? feedback;

  RatingModel({this.staffId, this.bookingServiceId, this.point, this.feedback});

  Map<String, dynamic> toJson() {
    return {
      'staffId': staffId,
      'bookingServiceId': bookingServiceId,
      'point': point,
      'feedback': feedback,
    };
  }
}
