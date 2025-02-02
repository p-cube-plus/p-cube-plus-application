import 'package:domain/product/repository/product_repository.dart';
import 'package:get_it/get_it.dart';

class RentProductUseCase {
  final _productRepository = GetIt.I.get<ProductRepository>();

  Future<void> call(String barcode) async {
    await _productRepository.rentProduct(barcode);
  }
}
