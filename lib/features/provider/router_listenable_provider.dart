import 'package:fixly/routes/refresh_listenable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerListenableprovider =
    Provider<AppRouterListenable>(
      (ref) => AppRouterListenable(ref),
    );
