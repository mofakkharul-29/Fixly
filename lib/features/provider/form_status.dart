import 'package:fixly/features/auth/data/form_notifier.dart';
import 'package:fixly/features/auth/model/form_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formStatusProvider =
    NotifierProvider<LogRegFormNotifier, LogRegFormState>(
      LogRegFormNotifier.new,
    );
