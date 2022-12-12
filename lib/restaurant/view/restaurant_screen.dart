import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/common/const/data.dart';
import 'package:flutter_delivery_app/device/wifi.dart';
import 'package:flutter_delivery_app/restaurant/component/restaurant_card.dart';
import 'package:get_it/get_it.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final ip = GetIt.I<NetworkIp>().ip;
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    String query = 'http://$ip/restaurant';
    print('query : $query');

    final resp = await dio.get(
      query,
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Center(
        child: FutureBuilder<List>(
          future: paginateRestaurant(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            print('snapshot err : ${snapshot.error}');
            print('snapshot data : ${snapshot.data}');
            return RestaurantCard(
              image: Image.asset(
                'asset/img/food/ddeok_bok_gi.jpg',
                fit: BoxFit.cover,
              ),
              name: '불타는 떡볶이',
              tags: [
                '떡볶이',
                '치즈',
                '매운맛',
              ],
              ratingsCount: 100,
              deliveryTime: 15,
              deliveryFee: 2000,
              ratings: 4.52,
            );
          },
        ),
      ),
    );
  }
}
