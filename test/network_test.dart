import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  test('NetworkInterface Find Wi-Fi', () async {
    List<NetworkInterface> networkInterface = await NetworkInterface.list();
    for (NetworkInterface interface in networkInterface) {
      if (interface.name == 'Wi-Fi') {
        print(interface.addresses.first.address);
      }
    }
  });

  // You must input NetworkInfo, Connectivity under runApp().
  // test('NetworkInfo Find Wi-Fi', () async {
  //   final packageInfo = NetworkInfo();
  //   final ip = await packageInfo.getWifiIP(); //
  //   print(ip);
  // });

  // test('Connectivity Find Wi-Fi', () async {
  //   ConnectivityResult connectResult = ConnectivityResult.none;
  //   connectResult = await Connectivity().checkConnectivity();
  //   print(connectResult.toString());
  // });
}
