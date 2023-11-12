class ItemModel {
  final int id;
  final String itemName;
  final int quantity;
  final String image;
  final String price;

  ItemModel({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.image,
    required this.price,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] ?? 0,
      itemName: map['itemName'] ?? '',
      quantity: map['quantity'] ?? 0,
      image: map['image']?.toString() ?? '', // Convert to string if necessary
      price: map['price']?.toString() ?? '', // Convert to string if necessary
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemName': itemName,
      'quantity': quantity,
      'image': image,
      'price': price,
    };
  }

  static List<ItemModel> fromMapList(List<dynamic> mapList) {
    return mapList.map((map) => ItemModel.fromMap(map)).toList();
  }

  static List<Map<String, dynamic>> toMapList(List<ItemModel> models) {
    return models.map((model) => model.toMap()).toList();
  }
}
