import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/common/const/data.dart';
import 'package:flutter_delivery_app/device/wifi.dart';
import 'package:flutter_delivery_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_delivery_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_delivery_app/restaurant/view/restaurant_detail.screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({
    Key? key,
  }) : super(key: key);

  Future<Map<String, dynamic>> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final query = 'http://$ip/restaurant';

    print('dio get : $query');

    final resp = await dio.get(
      query,
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    // Json Key ['meta', 'data']
    return resp.data; // .data mean body of json.
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: paginateRestaurant(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {

            print('snapshot err : ${snapshot.error}');
            print('snapshot data : ${snapshot.data}'); // Json List.
            // snapshot.data[index][key]

            if (!(snapshot.hasData) ||
                (snapshot.connectionState != ConnectionState.done)) {
              return const Center(child: CircularProgressIndicator());
            }

            final jsonRestaurants = snapshot.data!['data'];

            final restaurants = jsonRestaurants.map((jsonData) {
              return RestaurantModel.fromJson(jsonData);
            }).toList();

            return ListView.separated(
              itemCount: restaurants.length,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RestaurantDetailScreen(
                        id: restaurants[index].id,
                      ),
                    ),
                  );
                },
                child: RestaurantCard.fromModel(
                  model: restaurants[index],
                ),
              ),
              separatorBuilder: (_, index) {
                return const SizedBox(height: 16.0);
              },
            );
          },
        ),
      ),
    );
  }
}
