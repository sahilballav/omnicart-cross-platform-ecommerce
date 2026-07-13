import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stockQuantity;
  final List<String> imageUrls;
  final int? categoryId;
  final String? categoryName;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.imageUrls,
    this.categoryId,
    this.categoryName,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        stockQuantity,
        imageUrls,
        categoryId,
        categoryName,
      ];
}
