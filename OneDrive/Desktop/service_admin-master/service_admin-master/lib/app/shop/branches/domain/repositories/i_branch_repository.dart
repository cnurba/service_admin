import 'package:service_admin/app/shop/branches/domain/models/branch_model.dart';

abstract class IBranchRepository {
  /// Get all Branches.
  Future<List<BranchModel>> getAllBranches();

  /// Get Branch by id.
  Future<String> getBranchById(String id);

  /// Add a new Branch.
  Future<void> addBranch(BranchModel branch);

  /// Update an existing Branch.
  Future<void> updateBranch(String id, BranchModel branch);

  /// Delete a Branch by id.
  Future<void> deleteBranch(String id);
}
