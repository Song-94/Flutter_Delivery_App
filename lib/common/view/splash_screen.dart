import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/common/const/colors.dart';
import 'package:flutter_delivery_app/common/const/data.dart';
import 'package:flutter_delivery_app/common/layout/default_layout.dart';
import 'package:flutter_delivery_app/common/view/root_tab.dart';
import 'package:flutter_delivery_app/device/wifi.dart';
import 'package:flutter_delivery_app/user/view/login_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // initState 는 await 불가능.
    super.initState();

    deletedToken();
    checkToken();
  }

  void deletedToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    // refreshToken valid until 1day.
    // accessToken valid until 5min.

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();
    final ip = GetIt.I<NetworkIp>().ip;

    try {
      // normal process.
      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ),
      );

      await storage.write(
        key: REFRESH_TOKEN_KEY,
        value: resp.data['refreshToken'],
      );
      await storage.write(
        key: ACCESS_TOKEN_KEY,
        value: resp.data['accessToken'],
      );

      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const RootTab(),
          ),
          (route) => false,
        );
      });
    } catch (e) {
      // error process.
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'asset/img/logo/logo.svg',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 32.0),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
