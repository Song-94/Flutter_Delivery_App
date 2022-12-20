import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_delivery_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_delivery_app/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_delivery_app/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // ---------------------------------------------------------------------------
  // http://$ip/restaurant/
  @GET('/')
  @Headers(
    <String, dynamic>{
      'accessToken': 'true',
    },
  )
  Future<CursorPagination<RestaurantModel>>paginate();

  // ---------------------------------------------------------------------------
  // http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers(
    <String, dynamic>{
      'accessToken': 'true',
    },
  )
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
    // @Path('id') required String sid,
  });
}
