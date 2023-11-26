class CategoryListModel {
  List<CategoryModel>? values;

  CategoryListModel({this.values});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    return CategoryListModel(
      values: (json['values'] as List<dynamic>?)
          ?.map((item) => CategoryModel.fromJson(item))
          .toList(),
    );
  }
}

class CategoryModel {
  String? description;
  int? categoryId;
  String? title;
  List<SubServiceModel>? serviceList;

  CategoryModel(
      {this.description, this.categoryId, this.title, this.serviceList});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      description: json['description'],
      categoryId: json['categoryId'],
      title: json['title'],
      serviceList: (json['serviceList'] as List<dynamic>?)
          ?.map((item) => SubServiceModel.fromJson(item))
          .toList(),
    );
  }
}

class SubServiceModel {
  String? description;
  String? name;
  List<BranchServiceModel>? branchServiceList;

  SubServiceModel({this.description, this.name, this.branchServiceList});

  factory SubServiceModel.fromJson(Map<String, dynamic> json) {
    return SubServiceModel(
      description: json['description'],
      name: json['name'],
      branchServiceList: (json['branchServiceList'] as List<dynamic>?)
          ?.map((item) => BranchServiceModel.fromJson(item))
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
