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
  int selectedIndex = 0; // Default first selected
  final List<int> sizes = [70, 80, 90]; // Size list

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(
      productDetailFutureProvider(widget.productId),
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Детали о продукте")),
      body: productAsync.when(
        data: (FullProductModel product) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Carousel(),

                // Dynamic Size Text
                Text(
                  "Размер: ${sizes[selectedIndex]}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Size Selector
                Row(
                  children: List.generate(sizes.length, (index) {
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(color: Colors.black, width: 2)
                              : null,
                        ),
                        child: Text(
                          "${sizes[index]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 16),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description.isNotEmpty
                      ? product.description
                      : "Нет описания",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),

                ExpansionTile(
                  title: const Text(
                    "Детали о товаре:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Text(product.categoryName),
                    Text(product.brandName),
                    Text(product.branchName),
                  ],
                ),
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
