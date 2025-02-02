import 'package:domain/product/repository/product_repository.dart';
import 'package:domain/product/value_objects/user_rent_product.dart';
import 'package:get_it/get_it.dart';

class FetchUserRentProductListUseCase {
  final _productRepository = GetIt.I.get<ProductRepository>();

  Future<List<UserRentProduct>> call() async {
    final result = await _productRepository.getUserRentProductList();
    result.sort((a, b) => a.dDay.compareTo(b.dDay));
    return result;
  }
}
