import 'package:domain/product/value_objects/product.dart';
import 'package:domain/product/value_objects/product_detail.dart';
import 'package:domain/product/value_objects/search_result_product.dart';
import 'package:domain/product/value_objects/user_rent_product.dart';

abstract interface class ProductRepository {
  Future<List<UserRentProduct>> getUserRentProductList();
  Future<List<Product>> getTotalProduct();
  Future<ProductDetail> getProductDetail();
  Future<SearchResultProduct> getProductByBarcode(String barcode);
  Future<void> rentProduct(String barcode);
  Future<void> returnProduct();
}
