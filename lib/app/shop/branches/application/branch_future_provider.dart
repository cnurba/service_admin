import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/branches/domain/models/branch_model.dart';
import 'package:service_admin/app/shop/branches/domain/repositories/i_branch_repository.dart';
import 'package:service_admin/app/shop/branches/infrastructure/repositories/branch_repository.dart';
import 'package:service_admin/injection.dart';

final branchRepositoryProvider = Provider<IBranchRepository>(
  (ref) => BranchRepository(getIt<Dio>()),
);

final branchFutureProvider = FutureProvider.autoDispose<List<BranchModel>>((
  ref,
) async {
  final branchRepository = ref.watch(branchRepositoryProvider);
  final result = await branchRepository.getAllBranches();
  return result;
});
