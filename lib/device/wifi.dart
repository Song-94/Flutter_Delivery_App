import 'dart:io';

// localhost of emulator(android) & simulator(ios)
const emulatorIp = '10.0.2.2:3000';
const simulatorIp = '127.0.0.1:3000';
const notebookIp = '192.168.0.21:3000';
final ip = notebookIp ?? (Platform.isIOS ? simulatorIp : emulatorIp);

class NetworkIp {
  NetworkIp() {
    platformIp = Platform.isIOS ? simulatorIp : emulatorIp;
  }

  String? platformIp;
  String? wifiIp;

  String? get ip {
    return wifiIp ?? platformIp;
  }

  Future<void> getIpWiFi() async {
    // notebook Wi-Fi , phone : wlan0
    List<NetworkInterface> networkInterface = await NetworkInterface.list();
    for (NetworkInterface interface in networkInterface) {
      if (interface.name == 'wlan0') {
        wifiIp = '${interface.addresses.first.address}:3000';
        print('IP : $wifiIp');
      }
    }
  }

  void testWiFiList() async {
    for (var interface in await NetworkInterface.list()) {
      print('== Interface: ${interface.name} ==');
      for (var addr in interface.addresses) {
        print(
            '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
      }
    }
  }
}
