import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.parentId,
    super.subcategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    var subList = json['subcategories'] as List? ?? [];
    List<CategoryModel> subcategories = subList
        .map((subJson) => CategoryModel.fromJson(subJson as Map<String, dynamic>))
        .toList();

    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      parentId: json['parentId'] as int?,
      subcategories: subcategories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'parentId': parentId,
      'subcategories': subcategories.map((sub) => (sub as CategoryModel).toJson()).toList(),
    };
  }
}
