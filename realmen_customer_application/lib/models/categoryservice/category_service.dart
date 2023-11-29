import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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
  List<ServiceDisplayListModel>? serviceDisplayList;
  List<BranchServiceModel>? branchServiceList;

  SubServiceModel({
    this.description,
    this.name,
    this.serviceDisplayList,
    this.branchServiceList,
  });

  factory SubServiceModel.fromJson(Map<String, dynamic> json) {
    return SubServiceModel(
      description: json['description'],
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
