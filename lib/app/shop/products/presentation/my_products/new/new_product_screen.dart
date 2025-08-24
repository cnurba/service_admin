import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_controller.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_provider.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/pages/new_product_attribute_page.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/pages/new_product_images_page.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/pages/new_product_page.dart';
import 'package:service_admin/core/enums/state_type.dart';

class NewProductScreen extends ConsumerStatefulWidget {
  const NewProductScreen({super.key});

  @override
  ConsumerState<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends ConsumerState<NewProductScreen> {
  final _pageController = PageController();

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

    if (newProductState.stateType == StateType.success) {
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
                NewProductPage(),
                NewProductImagesPage(),
                if (_pageCount == 3) NewProductAttributeScreen(),
              ],
            ),
          ),
          //_buildNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
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
                        // if (formKey.currentState?.validate() ?? false) {
                        //controller.post();
                        _goNext();
                        //  }
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
