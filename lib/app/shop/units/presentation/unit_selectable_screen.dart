import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/units/application/unit_future_provider.dart';
import 'package:service_admin/core/presentation/indicators/loader.dart';

class UnitSelectableScreen extends StatelessWidget {
  const UnitSelectableScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выберите ЕИ')),
      body: Consumer(
        builder: (context, ref, child) {
          final resultAsync = ref.watch(unitFutureProvider);
          return resultAsync.when(
            data: (units) {
              if (units.isEmpty) {
                return const Center(child: Text('Пустой список ЕИ'));
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: units.length,
                itemBuilder: (context, index) {
                  final unit = units[index];
                  return ListTile(
                    title: Text(unit.name),
                    onTap: () {
                      Navigator.pop(context, unit);
                    },
                  );
                },
              );
            },
            loading: () => const Loader(),
            error: (error, stack) => Center(child: Text('Ошибка: $error')),
          );
        },
      ),
    );
  }
}
