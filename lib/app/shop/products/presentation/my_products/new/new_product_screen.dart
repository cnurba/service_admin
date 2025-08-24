import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/brands/presentation/select/brand_select_text_field.dart';
import 'package:service_admin/app/shop/categories/presentation/select/category_select_text_field.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_controller.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_provider.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_state.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/widgets/product_field.dart';
import 'package:service_admin/core/enums/state_type.dart';

class NewProductScreen extends ConsumerStatefulWidget {
  const NewProductScreen({super.key});

  @override
  ConsumerState<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends ConsumerState<NewProductScreen> {
  final _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  // Простейший список единиц измерения.
  static const List<String> _units = [
    "шт",
    "кг",
    "л",
    "м",
    "упаковка",
  ]; // можно расширить

  int get _pageCount {
    final hasAttrs = ref.watch(newProductProvider).newProduct.hasAttributes;
    return hasAttrs ? 3 : 2; // 1: форма, 2: изображения, 3 (опц): атрибуты
  }

  void _goNext() {
    final idx = _pageController.page?.round() ?? 0;
    if (idx < _pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goPrev() {
    final idx = _pageController.page?.round() ?? 0;
    if (idx > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newProductState = ref.watch(newProductProvider);
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

    if (newProductState.stateType==StateType.success) {
      // Успешно сохранено, выходим
      WidgetsBinding.instance.addPostFrameCallback((_) {
         _goNext();
        // true - чтобы обновить список
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Новый товар'),
        leading: IconButton(
          onPressed: () {
            controller.reset(); // сброс состояния при выходе
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              // управляем кнопками
              children: [
                _buildFormPage(context, newProductState, controller, _formKey),
                _buildImagesPage(),
                if (_pageCount == 3) _buildAttributesPage(),
              ],
            ),
          ),
          _buildNavigationBar(_formKey, controller),
        ],
      ),
    );
  }

  Widget _buildFormPage(
    BuildContext context,
    NewProductState newProductState,
    NewProductController controller,
    GlobalKey<FormState> formKey,
  ) {
    final product = newProductState.newProduct;
    return Form(
      key: formKey,
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
              initialValue: product.name,
              onChanged: controller.setName,
            ),

            ProductField(
              title: 'SKU / Артикул',
              initialValue: product.name,
              onChanged: controller.setName,
            ),
            // Dropdown единиц
            DropdownButtonFormField<String>(
              value: product.unit.isEmpty ? null : product.unit,
              decoration: const InputDecoration(labelText: 'Единица измерения'),
              items: _units
                  .map(
                    (u) => DropdownMenuItem<String>(value: u, child: Text(u)),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) controller.setUnit(v);
              },
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
          ],
        ),
      ),
    );
  }

  Widget _buildImagesPage() {
    return const Center(child: Text('Страница изображений (пока пусто)'));
  }

  Widget _buildAttributesPage() {
    return const Center(child: Text('Страница атрибутов (пока пусто)'));
  }

  Widget _buildNavigationBar(
    GlobalKey<FormState> formKey,
    NewProductController controller,
  ) {
    final idx = _pageController.hasClients
        ? _pageController.page?.round() ?? 0
        : 0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          if (idx > 0)
            ElevatedButton(onPressed: _goPrev, child: const Text('Назад')),
          if (idx > 0) const SizedBox(width: 12),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  switch (idx) {
                    case 0:
                      {
                        // Validate form
                        if (formKey.currentState?.validate() ?? false) {
                          controller.post();
                          //_goNext();
                        }
                      }
                    case 1:
                      _goNext;
                      break;
                    case 2:
                      null; // TODO: submit action
                  }
                },
                child: Text(idx == _pageCount - 1 ? 'Сохранить' : 'Далее'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
