import 'package:bloc_state_management/repposites/placeholder_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/post.dart';

part 'counter_provider.g.dart';

@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  Future<List<Post>> build() async {
    await Future.delayed(const Duration(seconds: 2));
    final placeholderRepo = ref.watch(placeholderRepositoryProvider);
    return placeholderRepo.getPosts();
  }
}
