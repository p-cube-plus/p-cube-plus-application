import 'package:domain/product/value_objects/user_rent_product.dart';

abstract interface class ProductRepository {
  Future<List<UserRentProduct>> getUserRentProductList();
}
