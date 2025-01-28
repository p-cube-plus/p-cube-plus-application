import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/product/usecase/fetch_total_product_use_case.dart';
import 'package:domain/product/usecase/fetch_user_rent_product_list_use_case.dart';
import 'package:domain/product/value_objects/product.dart';
import 'package:domain/product/value_objects/user_rent_product.dart';
import 'package:presentation/common/base_viewmodel.dart';

enum ProductFilterType {
  total,
  rentable,
  rented,
}

class ProductViewModel extends BaseViewModel<void> {
  final _fetchTotalProductUseCase = FetchTotalProductUseCase();
  final _fetchUserRentProductListUseCase = FetchUserRentProductListUseCase();

  ProductFilterType filterType = ProductFilterType.total;
  List<Product> totalList = [];
  bool isLoadingTotalProductList = true;

  List<Product>? get currentTargetList {
    if (isLoadingTotalProductList) return null;
    return switch (filterType) {
      ProductFilterType.total => totalList,
      ProductFilterType.rentable =>
        totalList.whereType<RentableProduct>().toList(),
      ProductFilterType.rented => totalList.whereType<RentedProduct>().toList(),
    };
  }

  Future<List<UserRentProduct>> fetchUserRentProductList() =>
      _fetchUserRentProductListUseCase();

  ProductViewModel() {
    fetchTotalList();
  }

  void fetchTotalList() async {
    isLoadingTotalProductList = true;
    notifyListeners();

    await _fetchTotalProductUseCase().then((result) {
      totalList = result;
    }).getOrNull();

    isLoadingTotalProductList = false;
    notifyListeners();
  }

  void changeFilterType(ProductFilterType newFilterType) {
    filterType = newFilterType;
    notifyListeners();
  }
}
