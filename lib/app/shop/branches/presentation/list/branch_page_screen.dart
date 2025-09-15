import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/branches/application/branch_future_provider.dart';
import 'package:service_admin/core/presentation/image/app_image_container.dart';

class BranchPageScreen extends ConsumerWidget {
  const BranchPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(branchFutureProvider);
    return resultAsync.when(
      data: (branches) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          itemCount: branches.length,
          itemBuilder: (context, index) {
            final branch = branches[index];
            return Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppImageContainer(
                      image: branch.imageUrl,
                      width: 64,
                      height: 64,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            branch.name,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(branch.description),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
