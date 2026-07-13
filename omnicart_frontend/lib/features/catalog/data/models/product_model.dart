import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.stockQuantity,
    required super.imageUrls,
    super.categoryId,
    super.categoryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var imagesList = json['imageUrls'] as List? ?? [];
    List<String> imageUrls = imagesList.map((img) => img as String).toList();

    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      stockQuantity: json['stockQuantity'] as int,
      imageUrls: imageUrls,
      categoryId: json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stockQuantity': stockQuantity,
      'imageUrls': imageUrls,
      'categoryId': categoryId,
      'categoryName': categoryName,
    };
  }
}
