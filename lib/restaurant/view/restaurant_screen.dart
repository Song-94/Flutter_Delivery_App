import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/common/const/data.dart';
import 'package:flutter_delivery_app/common/const/restaurant.dart';
import 'package:flutter_delivery_app/device/wifi.dart';
import 'package:flutter_delivery_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_delivery_app/restaurant/model/restaurant_model.dart';
import 'package:get_it/get_it.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  late Future<List> paginateRestaurant;

  Future<List> _paginateRestaurant() async {
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
  void initState() {
    // TODO: implement initState
    paginateRestaurant = _paginateRestaurant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ip = GetIt.I<NetworkIp>().ip;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Center(
        child: FutureBuilder<List>(
          future: paginateRestaurant,
          builder: (context, AsyncSnapshot<List> snapshot) {
            print('snapshot err : ${snapshot.error}');
            print('snapshot data : ${snapshot.data}');
            // snapshot.data[index][key]

            if (!(snapshot.hasData) ||
                (snapshot.connectionState != ConnectionState.done)) {
              return const Center(child: CircularProgressIndicator());
            }

            final models = snapshot.data!.map((jsonData) {
              return RestaurantModel.fromJson(jsonData);
            }).toList();


            return ListView.separated(
              itemCount: models.length,
              itemBuilder: (_, index) {
                final model = snapshot.data![index];
                final url = model['thumbUrl'];

                return RestaurantCard(
                  image: Image.network(
                    'http://$ip$url',
                    fit: BoxFit.cover,
                  ),
                  name: model['name'],
                  // Change to String List
                  // List<dynamic> -> List<String>.from
                  tags: List<String>.from(model['tags']),
                  ratingsCount: model['ratingsCount'],
                  deliveryTime: model['deliveryTime'],
                  deliveryFee: model['deliveryFee'],
                  ratings: model['ratings'],
                );
              },
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
