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
      serviceList: (json['serviceList'] as List?)
          ?.map((item) => ServiceList.fromJson(item))
          .toList(),
    );
  }
}

class ServiceList {
  String? name;
  String? description;
  int? price;
  int? serviceId;
  int? categoryId;
  String? categoryName;
  int? durationValue;
  String? durationTime;
  String? durationText;

  List<ServiceDisplayListModel>? serviceDisplayList;
  List<BranchServiceModel>? branchServiceList;

  ServiceList({
    this.name,
    this.description,
    this.price,
    this.serviceId,
    this.categoryId,
    this.categoryName,
    this.durationValue,
    this.durationTime,
    this.durationText,
    this.serviceDisplayList,
    this.branchServiceList,
  });

  factory ServiceList.fromJson(Map<String, dynamic> json) {
    return ServiceList(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      serviceId: json['serviceId'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      durationValue: json['durationValue'],
      durationTime: json['durationTime'],
      durationText: json['durationText'],
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
