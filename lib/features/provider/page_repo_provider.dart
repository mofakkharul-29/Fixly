import 'package:fixly/features/onboarding/data/repository/page_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageRepoNotifierProvider =
    NotifierProvider<PageRepo, int>(PageRepo.new);
