import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_delivery_app/common/dio/dio.dart';
import 'package:flutter_delivery_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_delivery_app/common/model/pagination_params.dart';
import 'package:flutter_delivery_app/device/wifi.dart';
import 'package:flutter_delivery_app/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_delivery_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository = RestaurantRepository(
      dio,
      baseUrl: 'http://$ip/restaurant',
    );
    return repository;
  },
);

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // ---------------------------------------------------------------------------
  // http://$ip/restaurant/
  // http://$ip/restaurant?Queries
  // paginationParams is Queries
  @GET('/')
  @Headers(
    <String, dynamic>{
      'accessToken': 'true',
    },
  )
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  // ---------------------------------------------------------------------------
  // http://$ip/restaurant/:id
  // id is path parameter.
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
