import 'package:bloc_state_management/providers/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/post.dart';

part 'placeholder_repository.g.dart';

@riverpod
PlaceholderRepository placeholderRepository(PlaceholderRepositoryRef ref) {
  throw UnimplementedError();
}

abstract class PlaceholderRepository {
  Future<List<Post>> getPosts();
}

class RemotePlaceholderRepository implements PlaceholderRepository {
  RemotePlaceholderRepository(this.ref);

  final Ref ref;

  @override
  Future<List<Post>> getPosts() async {
    final result = await ref.read(dioProvider).get<List<dynamic>>('posts');
    return result.data!.map((post) => Post.fromJson(post)).toList();
  }
}

class TestPlaceholderRepository implements PlaceholderRepository {
  @override
  Future<List<Post>> getPosts() async {
    return [
      const Post(id: 1, title: "Viet", body: "Hehe", userId: 1),
      const Post(id: 2, title: "Noi", body: "Hoho", userId: 2),
    ];
  }
}
