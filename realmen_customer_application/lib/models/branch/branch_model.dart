class BranchesModel {
  List<BranchModel>? content;
  int? totalElements;
  int? totalPages;
  int? pageSize;
  int? current;
  BranchesModel({
    this.content,
    this.totalElements,
    this.totalPages,
    this.pageSize,
    this.current,
  });
  factory BranchesModel.fromJson(Map<String, dynamic> json) {
    return BranchesModel(
        content: List<BranchModel>.from(
            json['content'].map((e) => BranchModel.fromJson(e))?.toList()),
        totalElements: json['totalElements'],
        totalPages: json['totalPages'],
        pageSize: json['pageSize'],
        current: json['current']);
  }
}

class BranchesByCityModel {
  List<BranchesValuesModel>? values;
  BranchesByCityModel({
    this.values,
  });
  factory BranchesByCityModel.fromJson(Map<String, dynamic> json) {
    return BranchesByCityModel(
      values: (json['values'] as List)
          ?.map((e) => BranchesValuesModel.fromJson(e))
          ?.toList(),
    );
  }
}

class BranchesValuesModel {
  String? city;
  List<BranchModel>? branches;
  BranchesValuesModel({
    this.city,
    this.branches,
  });
  factory BranchesValuesModel.fromJson(Map<String, dynamic> json) {
    return BranchesValuesModel(
      city: json['city'],
      branches: (json['branches'] as List)
          ?.map((e) => BranchModel.fromJson(e))
          ?.toList(),
    );
  }
}

class BranchModel {
  int? branchId;
  int? shopOwnerId;
  String? branchName;
  String? phone;
  String? address;
  String? status;
  int? numberStaffs;
  String? open;
  String? close;
  List<String>? displayUrlList;
  List<int>? serviceIdList;
  String? distanceKilometer;

  BranchModel(
      {this.branchId,
      this.shopOwnerId,
      this.branchName,
      this.phone,
      this.address,
      this.status,
      this.numberStaffs,
      this.open,
      this.close,
      this.displayUrlList,
      this.serviceIdList,
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
      // open: json['open'] != null ? OpenModel.fromJson(json['open']) : null,
      // close: json['close'] != null ? CloseModel.fromJson(json['close']) : null,
      displayUrlList: json['displayUrlList'] != null
          ? json['displayUrlList'].cast<String>()
          : null,
      serviceIdList: json['serviceIdList'] != null
          ? json['serviceIdList'].cast<int>()
          : null,
      distanceKilometer:
          json['distanceKilometer'] != null ? json['distanceKilometer'] : null,
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
