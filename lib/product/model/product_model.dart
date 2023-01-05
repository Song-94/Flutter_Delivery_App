import 'package:flutter_delivery_app/common/model/model_with_id.dart';
import 'package:flutter_delivery_app/common/utils/data_utils.dart';
import 'package:flutter_delivery_app/restaurant/model/restaurant_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  final String id;
  final String name; // 상품 이름
  final String detail; // 상품 상세 정보

  @JsonKey(
    // fromJson 함수 실행 시 실행 할 함수 지정.
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl; // 이미지 URL
  final int price; // 상품 가격
  final RestaurantModel restaurant; // 레스토랑 정보

  ProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
    required this.restaurant,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
