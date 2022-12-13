import 'package:flutter_delivery_app/common/const/restaurant.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_model.freezed.dart';

part 'restaurant_model.g.dart';

@freezed
class RestaurantModel with _$RestaurantModel {
  factory RestaurantModel({
    required String id,
    required String name,
    required String thumbUrl,
    required List<String?> tags,
    required RestaurantPriceRange priceRange,
    required double ratings,
    required int ratingsCount,
    required int deliveryTime,
    required int deliveryFee,
  }) = _RestaurantModel;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
}
