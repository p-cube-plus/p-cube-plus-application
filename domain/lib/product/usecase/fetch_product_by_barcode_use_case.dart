import 'package:domain/product/repository/product_repository.dart';
import 'package:domain/product/value_objects/search_result_product.dart';
import 'package:get_it/get_it.dart';

class FetchProductByBarcodeUseCase {
  final _productRepository = GetIt.I.get<ProductRepository>();

  Future<SearchResultProduct> call(String barcode) async {
    return await _productRepository.getProductByBarcode(barcode);
  }
}
