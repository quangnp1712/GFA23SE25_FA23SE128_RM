class RegisterCustomerModel {
  RegisterCustomerModel(
      {this.otpId,
      this.passCode,
      this.firstName,
      this.lastName,
      this.phone,
      this.address,
      this.gender,
      this.dob});

  int? otpId;
  String? passCode;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? gender;
  String? dob;

  // factory RegisterCustomerModel.fromJson(Map<String, dynamic> json) =>
  //     RegisterCustomerModel(
  //       firstName: json["firstName"],
  //       lastName: json["lastName"],
  //       phone: json["phone"],
  //       address: json["address"],
  //       gender: json["gender"],
  //       dob: json["dob"],
  //     );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "address": address,
        "gender": gender,
        "dob": dob
      };
}
