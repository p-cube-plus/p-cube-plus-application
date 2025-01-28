import 'package:domain/product/repository/product_repository.dart';
import 'package:domain/product/value_objects/product.dart';
import 'package:domain/product/value_objects/product_detail.dart';
import 'package:domain/product/value_objects/search_result_product.dart';
import 'package:domain/product/value_objects/user_rent_product.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<UserRentProduct>> getUserRentProductList() {
    // TODO: implement getUserRentProductList
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getTotalProduct() {
    // TODO: implement getTotalProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductDetail> getProductDetail() {
    // TODO: implement getProductDetail
    throw UnimplementedError();
  }

  @override
  Future<SearchResultProduct> getProductByBarcode(String barcode) {
    // TODO: implement getProductByBarcode
    throw UnimplementedError();
  }
  
  @override
  Future<void> returnProduct() {
    // TODO: implement returnProduct
    throw UnimplementedError();
  }
  
  @override
  Future<void> rentProduct(String barcode) {
    // TODO: implement rentProduct
    throw UnimplementedError();
  }
}
