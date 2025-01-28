import 'package:domain/product/repository/product_repository.dart';
import 'package:get_it/get_it.dart';

class ReturnProductUseCase {
  final _productRepository = GetIt.I.get<ProductRepository>();

  Future<void> call() async {
    await _productRepository.returnProduct();
  }
}
