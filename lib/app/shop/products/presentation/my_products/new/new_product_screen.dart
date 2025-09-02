import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/my_product_future_provider.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_images/new_product_image_provider.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_provider/new_product_provider.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/pages/new_product_attribute_page.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/pages/new_product_images_page.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/new/pages/new_product_page.dart';
import 'package:service_admin/core/extansions/router_extension.dart';
import 'package:service_admin/core/presentation/messenger/centered_snack.dart';

class NewProductScreen extends ConsumerStatefulWidget {
  const NewProductScreen({super.key});

  @override
  ConsumerState<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends ConsumerState<NewProductScreen> {
  late PageController _pageController;

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
  void initState() {
    /// initialize page controller
    _pageController = PageController();

    /// reset state when opening the screen.
    Future.microtask(() {
      ref.read(newProductProvider.notifier).reset();
      ref.read(newProductImageProvider.notifier).reset();
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новый товар'),
        leading: IconButton(
          onPressed: () {
            //controller.reset(); // сброс состояния при выходе
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
                NewProductPage(
                  onSuccess: (newId) {
                    ref
                        .read(newProductImageProvider.notifier)
                        .setProductUuid(newId);
                    _goNext();
                  },
                ),
                NewProductImagesPage(
                  onSuccess: () {
                    if (_pageCount == 3) {
                      _goNext();
                    } else {
                      /// Завершение создания товара
                      ref.read(newProductProvider.notifier).reset();
                      ref.read(newProductImageProvider.notifier).reset();

                      /// Показать сообщение об успешном создании товара
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Товар успешно создан')),
                      );
                      /// Обновить список моих товаров
                      ref.refresh(myProductFutureProvider);
                      /// Вернуться к списку моих товаров
                      Navigator.pop(context);

                    }
                  },
                ),
                NewProductAttributeScreen(),
              ],
            ),
          ), //newImageState
        ],
      ),
    );
  }
}
