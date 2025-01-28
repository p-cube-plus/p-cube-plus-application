import 'package:data/utils/mock_util.dart';
import 'package:domain/product/repository/product_repository.dart';
import 'package:domain/product/value_objects/product.dart';
import 'package:domain/product/value_objects/product_detail.dart';
import 'package:domain/product/value_objects/user_rent_product.dart';

class MockProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<UserRentProduct>> getUserRentProductList() async {
    await MockUtil().applyMockSetting();
    return [
      UserRentProduct(
        name: "클린코드",
        rentStartDate: DateTime.now(),
        rentEndDate: DateTime.now().add(Duration(days: 30)),
      ),
      UserRentProduct(
        name: "클린아키텍처",
        rentStartDate: DateTime.now().subtract(Duration(days: 20)),
        rentEndDate: DateTime.now().add(Duration(days: 2)),
      ),
      UserRentProduct(
        name: "도메인 주도 설계",
        rentStartDate: DateTime.now().subtract(Duration(days: 30)),
        rentEndDate: DateTime.now(),
      ),
      UserRentProduct(
        name: "동아리의 수상한 물품",
        rentStartDate: DateTime.now().subtract(Duration(days: 30)),
        rentEndDate: DateTime.now().add(Duration(days: 7)),
      ),
      UserRentProduct(
        name: "오뎅탕",
        rentStartDate: DateTime.now(),
        rentEndDate: DateTime.now().add(Duration(days: 20)),
      ),
      UserRentProduct(
        name: "나는 기한이 넘은 물품",
        rentStartDate: DateTime.now().subtract(Duration(days: 30)),
        rentEndDate: DateTime.now().subtract(Duration(days: 7)),
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

  @override
  Future<ProductDetail> getProductDetail() async {
    await MockUtil().applyMockSetting();
    return ProductDetail(
      rentStartDate: DateTime.now(),
      rentEndDate: DateTime.now().add(Duration(days: 30)),
      rentUserName:
          MockUtil().getRandom([null, MockUtil().getRandomKoreanName()]),
      detailInfoMap: {
        "도서정보": [
          ("도서명", "Lorem ipsum dolor sit amet"),
          ("출판사", "Lorem ipsum"),
          ("저자", MockUtil().getRandomKoreanName()),
        ],
        "물품정보": [
          ("이름", "Lorem ipsum dolor sit amet"),
          ("종류", "도서"),
          ("위치", "판도라큐브 구석 어딘가"),
        ],
        "카테고리가 이런식으로 추가됩니다.": [
          ("추가정보1", "추가정보에 대한 값이에요."),
          ("추가정보2", "언제든 추가 가능합니다. 물품이라면"),
          ("추가정보3", "물품이라면... 가능해요."),
          ("추가정보4", "임원진이 열심히 써주겠죠"),
          ("추가정보5", "DB에는 이게 잘 반영이 되어있으려나요"),
        ],
      },
    );
  }
}
