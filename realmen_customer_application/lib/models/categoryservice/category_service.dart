import 'package:realmen_customer_application/models/branch/branch_model.dart';

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
  int? categoryId;
  String? name;
  String? categoryType;
  List<ServiceList>? serviceList;

  CategoryModel({
    this.categoryId,
    this.name,
    this.categoryType,
    this.serviceList,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'],
      name: json['name'],
      categoryType: json['categoryType'],
      serviceList: (json['serviceList'] as List<dynamic>?)
          ?.map((item) => ServiceList.fromJson(item))
          .toList(),
    );
  }
}

class ServiceList {
  String? name;
  String? description;
  int? serviceId;

  List<ServiceDisplayListModel>? serviceDisplayList;
  List<BranchServiceModel>? branchServiceList;

  ServiceList({
    this.description,
    this.serviceId,
    this.name,
    this.serviceDisplayList,
    this.branchServiceList,
  });

  factory ServiceList.fromJson(Map<String, dynamic> json) {
    return ServiceList(
      description: json['description'],
      serviceId: json['serviceId'],
      name: json['name'],
      branchServiceList: (json['branchServiceList'] as List<dynamic>?)
          ?.map((item) => BranchServiceModel.fromJson(item))
          .toList(),
      serviceDisplayList: (json['serviceDisplayList'] as List<dynamic>?)
              ?.map((item) => ServiceDisplayListModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class ServiceDisplayListModel {
  int? serviceDisplayId;
  String? serviceDisplayUrl;

  ServiceDisplayListModel({
    this.serviceDisplayId,
    this.serviceDisplayUrl,
  });

  factory ServiceDisplayListModel.fromJson(Map<String, dynamic> json) {
    return ServiceDisplayListModel(
      serviceDisplayId: json['serviceDisplayId'],
      serviceDisplayUrl: json['serviceDisplayUrl'],
    );
  }
}
