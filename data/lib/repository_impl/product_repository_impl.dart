import 'package:domain/product/repository/product_repository.dart';
import 'package:domain/product/value_objects/product.dart';
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
}
