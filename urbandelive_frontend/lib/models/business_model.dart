import 'categories_model.dart';

class BusinessModel {
  final int id;
  final String businessName;
  final String businessNameSlug;
  final bool isActive;
  final List<CategoriesModel> categories;
  final String businessCategory;
  final String businessLogo;

  BusinessModel({
    required this.id,
    required this.businessName,
    required this.businessNameSlug,
    required this.isActive,
    required this.categories,
    required this.businessCategory,
    required this.businessLogo,
  });

  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
      id: map['id'] ?? 0,
      businessName: map['businessName'] ?? '',
      businessNameSlug: map['businessNameSlug'] ?? '',
      isActive: map['isActive'] ?? false,
      categories: CategoriesModel.fromMapList(map['categories'] ?? []),
      businessCategory: map['businessCategory'] ?? '',
      businessLogo: map['businessLogo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessName': businessName,
      'businessNameSlug': businessNameSlug,
      'isActive': isActive,
      'businessCategory': businessCategory,
      'businessLogo': businessLogo,
    };
  }

  static List<BusinessModel> fromMapList(List<dynamic> mapList) {
    return mapList.map((map) => BusinessModel.fromMap(map)).toList();
  }

  static List<Map<String, dynamic>> toMapList(List<BusinessModel> models) {
    return models.map((model) => model.toMap()).toList();
  }
}
