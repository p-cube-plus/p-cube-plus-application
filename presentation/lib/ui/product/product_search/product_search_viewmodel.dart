import 'package:domain/product/value_objects/product.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/utils/match_korean.dart';

class ProductSearchViewModel extends BaseViewModel<void> {
  final List<Product> _totalList;

  List<Product> get resultList =>
      _totalList.where((e) => e.name.matchKorean(searchText)).toList();
  String searchText = "";

  ProductSearchViewModel(this._totalList);

  void setSearchText(String newText) {
    searchText = newText;
    notifyListeners();
  }
}
