class CategoryServiceModel {
  // String description;
  int? categoryId;
  String? title;
  List<SubServiceModel>? serviceList;

  CategoryServiceModel({
    // required this.description,
    this.categoryId,
    this.title,
    this.serviceList,
  });

  factory CategoryServiceModel.fromJson(Map<String, dynamic> json) {
    return CategoryServiceModel(
      categoryId: json['categoryId'],
      title: json['title'],
      serviceList: (json['serviceList'] as List<dynamic>?)
          ?.map(
            (subService) => SubServiceModel.fromJson(subService),
          )
          .toList(),
    );
  }
}

class SubServiceModel {
  // String description;
  String? name;
  List<BranchServiceModel>? branchServiceList;

  SubServiceModel({
    // required this.description,
    this.name,
    this.branchServiceList,
  });

  factory SubServiceModel.fromJson(Map<String, dynamic> json) {
    return SubServiceModel(
      // description: json['description'],
      name: json['name'],
      branchServiceList: (json['branchServiceList'] as List<dynamic>)
          .map((branchService) => BranchServiceModel.fromJson(branchService))
          .toList(),
    );
  }
}

class BranchServiceModel {
  int? serviceId;
  int? branchId;
  String? serviceName;
  String? branchName;
  String? thumbnailUrl;
  int? price;

  BranchServiceModel({
    this.serviceId,
    this.branchId,
    this.serviceName,
    this.branchName,
    this.thumbnailUrl,
    this.price,
  });

  factory BranchServiceModel.fromJson(Map<String, dynamic> json) {
    return BranchServiceModel(
      serviceId: json['serviceId'],
      branchId: json['branchId'],
      serviceName: json['serviceName'],
      branchName: json['branchName'],
      thumbnailUrl: json['thumbnailUrl'],
      price: json['price'],
    );
  }
}
