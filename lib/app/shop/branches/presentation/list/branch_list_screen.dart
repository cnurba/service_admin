import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/branches/application/branch_future_provider.dart';

class BranchListScreen extends ConsumerWidget {
  const BranchListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(branchFutureProvider);
    return Scaffold(
      body: resultAsync.when(
        data: (branches) {
          return ListView.builder(
            itemCount: branches.length,
            itemBuilder: (context, index) {
              final branch = branches[index];
              return ListTile(
                title: Text(branch.name),
                subtitle: Text('ID: ${branch.id}'),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
