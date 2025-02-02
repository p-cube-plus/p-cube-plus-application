import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/product/usecase/fetch_product_by_barcode_use_case.dart';
import 'package:domain/product/usecase/rent_product_use_case.dart';
import 'package:domain/product/usecase/return_product_use_case.dart';
import 'package:domain/product/value_objects/product_type.dart';
import 'package:domain/product/value_objects/search_result_product.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/product/barcode_reader/floating_barcode_status.dart';

class FloatingBarcodeButtonViewModel
    extends BaseViewModel<FloatingBarcodeStatus> {
  final _fetchProductByBarcodeUseCase = FetchProductByBarcodeUseCase();
  final _rentProductUseCase = RentProductUseCase();
  final _returnProductUseCase = ReturnProductUseCase();
  SearchResultProduct? searchResult;

  void fetchProductByBarcode(String barcode) async {
    searchResult = await _fetchProductByBarcodeUseCase(barcode).getOrNull();
    triggerEvent(FloatingBarcodeStatusOnDismissLoading());

    if (searchResult == null) {
      triggerEvent(FloatingBarcodeStatusShowFailedDialog(
        "통신에 실패했습니다. 잠시 후 다시 시도해주세요.",
      ));
      return;
    }

    switch (searchResult!.productType) {
      case ProductType.notFound:
        triggerEvent(FloatingBarcodeStatusShowFailedDialog(
          "바코드: $barcode\n해당 물품을 찾지 못했습니다.",
        ));
      case ProductType.rentable:
        triggerEvent(FloatingBarcodeStatusShowRentDialog(
          "바코드: $barcode\n물품명: ${searchResult!.productName}",
        ));
      case ProductType.returnable:
        triggerEvent(FloatingBarcodeStatusShowReturnDialog(
          "반납하려면 블루투스를 켜주세요!\n바코드: $barcode\n물품명: ${searchResult!.productName}",
        ));
      case ProductType.rentedByOther:
        triggerEvent(FloatingBarcodeStatusShowFailedDialog(
          "해당 물품은 이미 ${searchResult!.rentUserName}님이 대여중입니다.",
        ));
    }
  }

  void rentProduct() {
    if (searchResult == null) return;
    _rentProductUseCase(searchResult!.barCode).then((_) {
      triggerEvent(FloatingBarcodeStatusOnSuccessRentDialog());
    }).onError((e, trace) {
      triggerEvent(FloatingBarcodeStatusShowFailedDialog(
        "통신에 실패했습니다. 잠시 후 다시 시도해주세요.",
      ));
    });
  }

  void returnProduct() async {
    _returnProductUseCase().then((_) {
      triggerEvent(FloatingBarcodeStatusOnSuccessReturnDialog());
    }).onError((e, trace) {
      triggerEvent(FloatingBarcodeStatusShowFailedDialog(
        "통신에 실패했습니다. 잠시 후 다시 시도해주세요.",
      ));
    });
  }
}
