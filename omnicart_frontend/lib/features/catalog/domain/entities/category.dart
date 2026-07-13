import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String slug;
  final int? parentId;
  final List<Category> subcategories;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    this.parentId,
    this.subcategories = const [],
  });

  @override
  List<Object?> get props => [id, name, slug, parentId, subcategories];
}
