import 'item_model.dart';

class CategoriesModel {
  final int id;
  final String categoryName;
  final String categoryType;
  final List<ItemModel> items; // Added field for items

  CategoriesModel({
    required this.id,
    required this.categoryName,
    required this.categoryType,
    required this.items,
  });

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      id: map['id'] ?? 0,
      categoryName: map['categoryName'] ?? '',
      categoryType: map['categoryType'] ?? '',
      items: ItemModel.fromMapList(map['items'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryName': categoryName,
      'categoryType': categoryType,
      'items': ItemModel.toMapList(items),
    };
  }

  static List<CategoriesModel> fromMapList(List<dynamic> mapList) {
    return mapList.map((map) => CategoriesModel.fromMap(map)).toList();
  }

  static List<Map<String, dynamic>> toMapList(List<CategoriesModel> models) {
    return models.map((model) => model.toMap()).toList();
  }
}
