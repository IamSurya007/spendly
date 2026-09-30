import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/repositories/i_category_repository.dart';
import '../../../core/repositories/isar_category_repository.dart';
import '../models/category.dart';
import 'category_registry.dart';

final categoryRepositoryProvider = Provider<ICategoryRepository>((ref) {
  return IsarCategoryRepository();
});

final userCategoriesStreamProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(categoryRepositoryProvider).watchUserCategories();
});

/// The effective categories (system + user). Falls back to the system
/// taxonomy while the local database is loading, so it never blocks the UI.
final categoryRegistryProvider = Provider<CategoryRegistry>((ref) {
  final user = ref.watch(userCategoriesStreamProvider).valueOrNull;
  return user == null ? CategoryRegistry.systemOnly : CategoryRegistry(user);
});
