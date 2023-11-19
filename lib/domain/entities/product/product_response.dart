import 'pagination_meta_data.dart';
import 'product.dart';

class ProductResponse {
  final List<ProductEntity> products;
  final PaginationMetaData paginationMetaData;

  ProductResponse({required this.products, required this.paginationMetaData});
}