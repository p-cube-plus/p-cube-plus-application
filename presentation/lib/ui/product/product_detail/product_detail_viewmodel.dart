import 'package:domain/product/usecase/fetch_product_detail_use_case.dart';
import 'package:domain/product/value_objects/product_detail.dart';
import 'package:presentation/common/base_viewmodel.dart';

class ProductDetailViewModel extends BaseViewModel<void> {
  final _fetchProductDetailUseCase = FetchProductDetailUseCase();

  Future<ProductDetail> fetchProductDetail() => _fetchProductDetailUseCase();
}
