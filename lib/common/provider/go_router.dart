import 'package:flutter_delivery_app/user/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    // watch - 값이 변경 될 때마다 다시 빌드
    // read - 최초 한번만 빌드.
    final provider = ref.read(authProvider);

    return GoRouter(
      routes: provider.routes,
      initialLocation: '/splash',
      refreshListenable: provider,
      redirect: provider.redirectLogic,
    );
  },
);
