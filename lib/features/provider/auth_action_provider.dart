import 'package:fixly/features/auth/data/auth_notifier.dart';
import 'package:fixly/features/auth/model/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotiferProvider =
    AsyncNotifierProvider<AuthNotifier, AppUser?>(
      AuthNotifier.new,
    );
