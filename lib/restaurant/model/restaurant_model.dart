import 'package:flutter_delivery_app/common/const/restaurant_price.dart';
import 'package:flutter_delivery_app/common/utils/data_utils.dart';

import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;

  @JsonKey(
    // fromJson 함수 실행 시 실행 할 함수 지정.
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;

  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
}
