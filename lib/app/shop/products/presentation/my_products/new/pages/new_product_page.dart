import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/presentation/select/brand_select_text_field.dart';
import 'package:service_admin/app/shop/categories/presentation/select/category_select_text_field.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_provider.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/widgets/product_field.dart';
import 'package:service_admin/app/shop/units/presentation/unit_select_text_field.dart';
import 'package:service_admin/core/presentation/errors/state_wrapper.dart';

class NewProductPage extends ConsumerStatefulWidget {
  const NewProductPage({super.key, this.onSuccess});

  final Function(String)? onSuccess;

  @override
  ConsumerState<NewProductPage> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends ConsumerState<NewProductPage> {

  final _productFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newProductState = ref.watch(newProductProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_productFormKey.currentState?.validate() ?? false) {
            ref.read(newProductProvider.notifier).post();
          }
        },
        label: const Text('Сохранить' ),
        icon: const Icon(Icons.save),
      ),
      body: Form(
        key: _productFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ProductField(
                title: 'Наименование',
                initialValue: newProductState.newProduct.name,
                onChanged: (name) {
                  ref.read(newProductProvider.notifier).setName(name);
                },
              ),
              ProductField(
                title: 'Описание',
                initialValue: newProductState.newProduct.description,
                onChanged: (description) {
                  ref
                      .read(newProductProvider.notifier)
                      .setDescription(description);
                },
              ),
              ProductField(
                title: 'SKU / Артикул',
                initialValue: newProductState.newProduct.sku,
                onChanged: (sku) {
                  ref.read(newProductProvider.notifier).setSku(sku);
                },
              ),
              // Dropdown единиц
              UnitSelectTextField(
                onSelected: (unit) {
                  ref.read(newProductProvider.notifier).setUnit(unit);
                },
                initialValue: newProductState.newProduct.unit.name,
              ),

              CategorySelectTextField(
                initialValue: newProductState.newProduct.category.name,
                onSelected: (category) {
                  ref.read(newProductProvider.notifier).setCategory(category);
                },
              ),

              BrandSelectTextField(
                initialValue: newProductState.newProduct.brand.name,
                onSelected: (brand) {
                  ref.read(newProductProvider.notifier).setBrand(brand);
                },
              ),

              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text('Активен'),
                value: newProductState.newProduct.isActive,
                onChanged: (value) {
                  ref.read(newProductProvider.notifier).setIsActive(value);
                },
              ),
              SwitchListTile(
                title: const Text('Есть атрибуты'),
                value: newProductState.newProduct.hasAttributes,
                onChanged: (value) {
                  ref.read(newProductProvider.notifier).setHasAttributes(value);
                },
              ),
              const SizedBox(height: 32),
              StateWrapper(
                stateType: newProductState.stateType,
                onSuccess: () {
                  if (widget.onSuccess != null) {
                    widget.onSuccess!(newProductState.newProductId);
                  }
                },
                child: SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
