import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_delivery_app/common/dio/dio.dart';
import 'package:flutter_delivery_app/common/repository/base_pagination_repository.dart';
import 'package:flutter_delivery_app/device/wifi.dart';
import 'package:flutter_delivery_app/rating/model/rating_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flutter_delivery_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_delivery_app/common/model/pagination_params.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>(
  (ref, id) {
    final dio = ref.watch(dioProvider);
    return RestaurantRatingRepository(dio,
        baseUrl: 'http://$ip/restaurant/$id/rating');
  },
);

// baseUrl
// http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingModel> {

  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/')
  @Headers(
    <String, dynamic>{
      'accessToken': 'true',
    },
  )

  @override
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
