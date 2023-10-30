class BranchesModel {
  List<BranchModel>? content;
  int? total;
  int? pageSize;
  int? current;
  BranchesModel({
    this.content,
    this.total,
    this.pageSize,
    this.current,
  });
  factory BranchesModel.fromJson(Map<String, dynamic> json) {
    return BranchesModel(
        content: (json['content'] as List)
            ?.map((e) => BranchModel.fromJson(e))
            ?.toList(),
        total: json['total'],
        pageSize: json['pageSize'],
        current: json['current']);
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
  OpenModel? open;
  CloseModel? close;
  List<String>? displayUrlList;
  List<int>? serviceIdList;

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
      this.serviceIdList});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
        branchId: json['branchId'],
        shopOwnerId: json['shopOwnerId'],
        branchName: json['branchName'],
        phone: json['phone'],
        address: json['address'],
        status: json['status'],
        numberStaffs: json['numberStaffs'],
        open: json['open'] != null ? OpenModel.fromJson(json['open']) : null,
        close:
            json['close'] != null ? CloseModel.fromJson(json['close']) : null,
        displayUrlList: json['displayUrlList'] != null
            ? json['displayUrlList'].cast<String>()
            : null,
        serviceIdList: json['serviceIdList'] != null
            ? json['serviceIdList'].cast<int>()
            : null);
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
