class ServiceModel {
  List<ServiceContent>? content;
  int? totalElements;
  int? totalPages;
  int? pageSize;
  int? current;

  ServiceModel({
    this.content,
    this.totalElements,
    this.totalPages,
    this.pageSize,
    this.current,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      content: (json['content'] as List<dynamic>?)
          ?.map((item) => ServiceContent.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      pageSize: json['pageSize'],
      current: json['current'],
    );
  }
}

class ServiceContent {
  String? description;
  int? serviceId;
  String? name;
  List<ServiceDisplay>? serviceDisplayList;
  List<BranchService>? branchServiceList;

  ServiceContent({
    this.description,
    this.serviceId,
    this.name,
    this.serviceDisplayList,
    this.branchServiceList,
  });

  factory ServiceContent.fromJson(Map<String, dynamic> json) {
    return ServiceContent(
      description: json['description'],
      name: json['name'],
      serviceId: json['serviceId'],
      serviceDisplayList: json['serviceDisplayList'] != null
          ? (json['serviceDisplayList'] as List<dynamic>?)
              ?.map((display) => ServiceDisplay.fromJson(display))
              .toList()
          : null,
      branchServiceList: json['branchServiceList'] != null
          ? (json['branchServiceList'] as List<dynamic>?)
              ?.map((branch) => BranchService.fromJson(branch))
              .toList()
          : null,
    );
  }
}

class ServiceDisplay {
  final int? serviceDisplayId;
  final String? serviceDisplayUrl;

  const ServiceDisplay({
    this.serviceDisplayId,
    this.serviceDisplayUrl,
  });

  factory ServiceDisplay.fromJson(Map<String, dynamic> json) {
    return ServiceDisplay(
      serviceDisplayId: json['serviceDisplayId'] as int,
      serviceDisplayUrl: json['serviceDisplayUrl'] as String,
    );
  }
}

class BranchService {
  final int? serviceId;
  final int? branchId;
  final String? serviceName;
  final String? branchName;
  final String? thumbnailUrl;
  final int? price;

  const BranchService({
    this.serviceId,
    this.branchId,
    this.serviceName,
    this.branchName,
    this.thumbnailUrl,
    this.price,
  });

  factory BranchService.fromJson(Map<String, dynamic> json) {
    return BranchService(
      serviceId: json['serviceId'] as int,
      branchId: json['branchId'] as int,
      serviceName: json['serviceName'] as String,
      branchName: json['branchName'] as String,
      thumbnailUrl: json['thumbnailUrl'],
      price: json['price'] != null ? json['price'] as int : null,
    );
  }
}
