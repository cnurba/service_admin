import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:service_admin/app/shop/branches/domain/models/branch_model.dart';
import 'package:service_admin/app/shop/branches/domain/repositories/i_branch_repository.dart';
import 'package:service_admin/app/shop/branches/infrastructure/dtos/branch_dto.dart';
import 'package:service_admin/core/http/endpoints.dart';

class BranchRepository implements IBranchRepository {
  final Dio _dio;

  BranchRepository(this._dio);

  @override
  Future<void> addBranch(BranchModel branch) {
    // TODO: implement addBranch
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBranch(String id) {
    // TODO: implement deleteBranch
    throw UnimplementedError();
  }

  @override
  Future<List<BranchModel>> getAllBranches() async {
    try {
      final responseData = await _dio.get(Endpoints.branches.branches);
      if (responseData.statusCode == 200) {
        final branchesList = (responseData.data as List)
            .map((branches) => BranchDto.fromJson(branches).toBranch())
            .toList();
        log("FINISH Branches length  ${branchesList.length}");
        return branchesList;
      } else {
        throw Exception('Failed to load Branches');
      }
    } catch (e) {
      throw Exception('Error fetching Branches: $e');
    }
  }

  @override
  Future<String> getBranchById(String id) {
    // TODO: implement getBranchById
    throw UnimplementedError();
  }

  @override
  Future<void> updateBranch(String id, BranchModel branch) {
    // TODO: implement updateBranch
    throw UnimplementedError();
  }
}
