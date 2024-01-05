class BranchesModel {
  List<BranchesValuesModel>? values;
  BranchesModel({
    this.values,
  });
  factory BranchesModel.fromJson(Map<String, dynamic> json) {
    return BranchesModel(
      values: (json['values'] as List)
          .map((e) => BranchesValuesModel.fromJson(e))
          .toList(),
    );
  }
}

class BranchesValuesModel {
  String? city;
  int? branch;
  List<BranchModel>? branchList;
  BranchesValuesModel({
    this.city,
    this.branch,
    this.branchList,
  });
  factory BranchesValuesModel.fromJson(Map<String, dynamic> json) {
    return BranchesValuesModel(
      city: json['city'],
      branch: json['branch'],
      branchList: json['branchList'] != null
          ? (json['branchList'] as List)
              .map((e) => BranchModel.fromJson(e))
              .toList()
          : null,
    );
  }
}

class BranchModel {
  int? branchId;
  int? shopOwnerId;
  String? branchName;
  String? thumbnailUrl;
  String? phone;
  String? address;
  String? status;
  int? numberStaffs;
  String? open;
  String? close;
  List<String>? displayUrlList;
  List<BranchServiceModel>? branchServiceList;
  String? distanceKilometer;

  BranchModel(
      {this.branchId,
      this.shopOwnerId,
      this.branchName,
      this.thumbnailUrl,
      this.phone,
      this.address,
      this.status,
      this.numberStaffs,
      this.open,
      this.close,
      this.displayUrlList,
      this.branchServiceList,
      this.distanceKilometer});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      branchId: json['branchId'],
      shopOwnerId: json['shopOwnerId'],
      branchName: json['branchName'],
      phone: json['phone'],
      address: json['address'],
      status: json['status'],
      numberStaffs: json['numberStaffs'],
      open: json['open'],
      close: json['close'],
      displayUrlList: json['displayUrlList'].cast<String>(),
      branchServiceList: json['branchServiceList'] != null
          ? (json['branchServiceList'] as List)
              .map((e) => BranchServiceModel.fromJson(e))
              .toList()
          : null,
      distanceKilometer: json['distanceKilometer'],
    );
  }
}

class OpenModel {
  int? hour;
  int? minute;
  int? second;
  int? nano;

  OpenModel({
    this.hour,
    this.minute,
    this.second,
    this.nano,
  });

  factory OpenModel.fromJson(Map<String, dynamic> json) {
    return OpenModel(
      hour: json['hour'],
      minute: json['minute'],
      second: json['second'],
      nano: json['nano'],
    );
  }
}

class CloseModel {
  int? hour;
  int? minute;
  int? second;
  int? nano;

  CloseModel({
    this.hour,
    this.minute,
    this.second,
    this.nano,
  });

  factory CloseModel.fromJson(Map<String, dynamic> json) {
    return CloseModel(
      hour: json['hour'],
      minute: json['minute'],
      second: json['second'],
      nano: json['nano'],
    );
  }
}

class BranchServiceModel {
  int? serviceId;
  int? branchId;
  String? branchName;
  String? thumbnailUrl;
  int? price;

  BranchServiceModel(
      {this.serviceId,
      this.branchId,
      this.branchName,
      this.thumbnailUrl,
      this.price});

  factory BranchServiceModel.fromJson(Map<String, dynamic> json) =>
      BranchServiceModel(
          serviceId: json["serviceId"],
          branchId: json["branchId"],
          branchName: json["branchName"],
          thumbnailUrl: json["thumbnailUrl"],
          price: json["price"]);
}
