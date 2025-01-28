import 'package:data/utils/mock_util.dart';
import 'package:domain/product/repository/product_repository.dart';
import 'package:domain/product/value_objects/product.dart';
import 'package:domain/product/value_objects/user_rent_product.dart';

class MockProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<UserRentProduct>> getUserRentProductList() async {
    await MockUtil().applyMockSetting();
    return [
      UserRentProduct(
        name: "클린코드",
        rentStartDate: DateTime.now(),
        rendEndDate: DateTime.now().add(Duration(days: 30)),
      ),
      UserRentProduct(
        name: "클린아키텍처",
        rentStartDate: DateTime.now().subtract(Duration(days: 20)),
        rendEndDate: DateTime.now().add(Duration(days: 2)),
      ),
      UserRentProduct(
        name: "도메인 주도 설계",
        rentStartDate: DateTime.now().subtract(Duration(days: 30)),
        rendEndDate: DateTime.now(),
      ),
      UserRentProduct(
        name: "동아리의 수상한 물품",
        rentStartDate: DateTime.now().subtract(Duration(days: 30)),
        rendEndDate: DateTime.now().add(Duration(days: 7)),
      ),
      UserRentProduct(
        name: "오뎅탕",
        rentStartDate: DateTime.now(),
        rendEndDate: DateTime.now().add(Duration(days: 20)),
      ),
      UserRentProduct(
        name: "나는 기한이 넘은 물품",
        rentStartDate: DateTime.now().subtract(Duration(days: 30)),
        rendEndDate: DateTime.now().subtract(Duration(days: 7)),
      ),
    ];
  }

  @override
  Future<List<Product>> getTotalProduct() async {
    await MockUtil().applyMockSetting();
    return List<Product>.generate(20, (index) {
          return RentableProduct(
            name: "물품$index",
            typeName: "도서",
            location: "책상1-책장1-A$index",
          );
        }) +
        List<Product>.generate(20, (index) {
          return RentedProduct(
            name: "물품$index",
            typeName: "도서",
            location: "책상1-책장2-A$index",
            rentUserName: MockUtil().getRandomKoreanName(),
            rentStartDate: MockUtil().getRandomDateTime(
                DateTime.now().subtract(Duration(days: 30)), DateTime.now()),
            rentEndDate: MockUtil().getRandomDateTime(
                DateTime.now(), DateTime.now().add(Duration(days: 30))),
          );
        });
  }
}
