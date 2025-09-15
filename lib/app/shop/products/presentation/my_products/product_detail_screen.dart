import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/product_by_product_id_provider.dart';
import 'package:service_admin/app/shop/products/domain/models/full_product_model.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/widgets/carousel_slider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(
      productDetailFutureProvider(widget.productId),
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Детали о продукте")),
      body: productAsync.when(
        data: (ProductDetailModel product) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  images: product.imageUrls,
                  sliderHeight: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 12),

                product.attributes.isNotEmpty
                    ? Text(
                        "Атрибуты: ${product.attributes.map((attr) => attr.name).join(', ')}",
                      )
                    : const Text("Нет атрибутов"),

                const SizedBox(height: 16),
                Text(product.name),
                const SizedBox(height: 8),
                Text(
                  product.description.isNotEmpty
                      ? product.description
                      : "Нет описания",
                ),
                const SizedBox(height: 10),
                Text("Категория: ${product.categoryName}"),
                const SizedBox(height: 6),
                Text("Бренд: ${product.brandName}"),
                const SizedBox(height: 6),
                Text("Филиал: ${product.branchName}"),
                const SizedBox(height: 6),
                Text("Активен: ${product.isActive ? "Да" : "Нет"}"),
                const SizedBox(height: 6),
                Text("Рекомендуемый: ${product.isFeatured ? "Да" : "Нет"}"),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
        error: (error, _) => Center(child: Text("Ошибка: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
