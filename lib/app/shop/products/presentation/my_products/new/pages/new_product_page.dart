import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/presentation/select/brand_select_text_field.dart';
import 'package:service_admin/app/shop/categories/presentation/select/category_select_text_field.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_controller.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_provider.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_state.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/pages/new_product_images_page.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/widgets/product_field.dart';
import 'package:service_admin/app/shop/units/presentation/unit_select_text_field.dart';
import 'package:service_admin/core/enums/state_type.dart';


class NewProductPage extends ConsumerStatefulWidget {
  const NewProductPage({super.key});

  @override
  ConsumerState<NewProductPage> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends ConsumerState<NewProductPage> {
  final _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  int get _pageCount {
    final hasAttrs = ref
        .watch(newProductProvider)
        .newProduct
        .hasAttributes;
    return hasAttrs ? 3 : 2; // 1: форма, 2: изображения, 3 (опц): атрибуты
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newProductState = ref.watch(newProductProvider);
    final product = newProductState.newProduct;
    final NewProductController controller = ref.read(
      newProductProvider.notifier,
    );
    // Если пользователь снял галочку hasAttributes, а мы стоим на последней (3й) странице — вернемся назад.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final current = _pageController.page?.round() ?? 0;
      if (current == 2 && _pageCount == 2) {
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });

    if (newProductState.stateType == StateType.success) {
      // Успешно сохранено, выходим
      WidgetsBinding.instance.addPostFrameCallback((_) {
        //_goNext();
        // true - чтобы обновить список
      });
    }

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductField(
              title: 'Название',
              initialValue: product.name,
              onChanged: controller.setName,
            ),

            ProductField(
              title: 'Описание',
              initialValue: product.description,
              onChanged: controller.setDescription,
            ),

            ProductField(
              title: 'SKU / Артикул',
              initialValue: product.sku,
              onChanged: controller.setSku,
            ),
            // Dropdown единиц
            UnitSelectTextField(
              onSelected: controller.setUnit,
              initialValue: product.unit.name,
            ),

            CategorySelectTextField(
              initialValue: product.category.name,
              onSelected: (category) {
                controller.setCategory(category);
              },
            ),

            BrandSelectTextField(
              initialValue: product.brand.name,
              onSelected: (brand) {
                controller.setBrand(brand);
              },
            ),

            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Активен'),
              value: product.isActive,
              onChanged: controller.setIsActive,
            ),
            SwitchListTile(
              title: const Text('Есть атрибуты'),
              value: product.hasAttributes,
              onChanged: controller.setHasAttributes,
            ),
            SwitchListTile(
              title: const Text('Избранный'),
              value: product.isFeatured,
              onChanged: controller.setIsFeatured,
            ),

            ElevatedButton(onPressed:(){
              if( _formKey.currentState?.validate() ?? false){
                controller.post();
              }

            } , child: const Text('Сохранить')),
          ],
        ),
      ),
    );
  }


}
