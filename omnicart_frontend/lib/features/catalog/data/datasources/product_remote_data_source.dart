import 'package:dio/dio.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    String? search,
    int page = 0,
    int size = 10,
  });

  Future<ProductModel> getProductById(String id);
  Future<List<CategoryModel>> getCategoryTree();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'http://localhost:8080/api/v1'; // API Gateway Base URL

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProducts({
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    String? search,
    int page = 0,
    int size = 10,
  }) async {
    final queryParameters = {
      'page': page,
      'size': size,
    };

    if (categoryId != null) queryParameters['categoryId'] = categoryId;
    if (minPrice != null) queryParameters['minPrice'] = minPrice;
    if (maxPrice != null) queryParameters['maxPrice'] = maxPrice;
    if (search != null && search.isNotEmpty) queryParameters['search'] = search;

    final response = await dio.get(
      '$baseUrl/products',
      queryParameters: queryParameters,
    );

    // Spring Data Page object returns contents inside 'content' field
    final List contentList = response.data['content'] as List? ?? [];
    return contentList.map((item) => ProductModel.fromJson(item as Map<String, dynamic>)).toList();
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await dio.get('$baseUrl/products/$id');
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<CategoryModel>> getCategoryTree() async {
    final response = await dio.get('$baseUrl/categories');
    final List list = response.data as List? ?? [];
    return list.map((item) => CategoryModel.fromJson(item as Map<String, dynamic>)).toList();
  }
}
