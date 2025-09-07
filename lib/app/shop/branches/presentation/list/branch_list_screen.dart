import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/branches/presentation/list/branch_page_screen.dart';

class BranchListScreen extends ConsumerWidget {
  const BranchListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Магазины и Филиалы',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
      body: BranchPageScreen(),
    );
  }
}
