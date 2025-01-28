import 'package:domain/product/repository/product_repository.dart';
import 'package:domain/product/value_objects/product_detail.dart';
import 'package:get_it/get_it.dart';

class FetchProductDetailUseCase {
  final _productRepository = GetIt.I.get<ProductRepository>();

  Future<ProductDetail> call() async {
    return await _productRepository.getProductDetail();
  }
}
