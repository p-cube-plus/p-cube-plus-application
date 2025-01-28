import 'package:domain/product/usecase/fetch_user_rent_product_list_use_case.dart';
import 'package:domain/product/value_objects/user_rent_product.dart';
import 'package:presentation/common/base_viewmodel.dart';

class HomeRentViewmodel extends BaseViewModel<void> {
  final _fetchUserRentProductListUseCase = FetchUserRentProductListUseCase();

  Future<List<UserRentProduct>> fetchUserRentProductList() =>
      _fetchUserRentProductListUseCase();
}
