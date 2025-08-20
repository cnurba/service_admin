import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/product_future_provider.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final Set<String> _selectedProducts = {}; // store selected IDs
  String _searchQuery = "";
  List<dynamic> _allProducts = []; // store all products here

  @override
  Widget build(BuildContext context) {
    final resultAsync = ref.watch(productFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Товары')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Поиск товаров...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child: resultAsync.when(
              data: (products) {
                _allProducts = products;
                final filtered = products.where((p) {
                  return p.name.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  );
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text("Товары не найдены"));
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final product = filtered[index];
                    final isChecked = _selectedProducts.contains(product.id);

                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: isChecked,
                      title: Text(product.name),
                      subtitle: Text("ID: ${product.id}"),
                      onChanged: (bool? checked) {
                        setState(() {
                          if (checked == true) {
                            _selectedProducts.add(product.id);
                          } else {
                            _selectedProducts.remove(product.id);
                          }
                        });
                      },
                    );
                  },
                );
              },
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),

      bottomNavigationBar: _selectedProducts.isEmpty
          ? const SizedBox.shrink() // hide if nothing selected
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected: ${_selectedProducts.length}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _selectedProducts.map((id) {
                        final product = _allProducts.firstWhereOrNull(
                          (p) => "${p.id}-${_allProducts.indexOf(p)}" == id,
                        );
                        if (product == null) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Chip(
                            label: Text(product.name),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () {
                              setState(() {
                                _selectedProducts.remove(id);
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "You selected ${_selectedProducts.length} products",
              ),
            ),
          );
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
