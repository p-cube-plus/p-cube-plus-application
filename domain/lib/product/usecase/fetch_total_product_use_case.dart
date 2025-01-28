import 'package:domain/product/repository/product_repository.dart';
import 'package:domain/product/value_objects/product.dart';
import 'package:get_it/get_it.dart';

class FetchTotalProductUseCase {
  final _productRepository = GetIt.I.get<ProductRepository>();

  Future<List<Product>> call() async {
    return await _productRepository.getTotalProduct();
  }
}
