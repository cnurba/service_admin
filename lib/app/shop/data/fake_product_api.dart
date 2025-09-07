import 'dart:async';

/// Fake API service for testing without a real backend.
class FakeProductApi {
  /// Simulate fetching a product by its ID
  Future<Map<String, dynamic>> getProductById(String productId) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return _fakeProduct; // Return the same fake product for now
  }

  /// Simulate fetching all products
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return [_fakeProduct]; // Return one product in a list
  }
}

/// 🔹 Fake product JSON (copied from your API)
const Map<String, dynamic> _fakeProduct = {
  "uuid": "dad1e32d-6532-11f0-bb1b-a27a3a20c615",
  "name": "Мык 17",
  "description": "РОССИЯ ӨНДҮРҮШҮ",
  "categoryId": "4c09922b-4ced-11f0-bb17-a7127118ea41",
  "categoryName": "ТЕМИР ӨНДҮРҮШТӨРҮ",
  "brandId": "74275bdf-56ff-11f0-bb1b-a27a3a20c615",
  "brandName": "ФУРКАТ",
  "branchId": "182c0b34-6532-11f0-bb1b-a27a3a20c615",
  "branchName": "АПСАТАР АТА2",
  "sku": "",
  "isActive": true,
  "hasAttributes": true,
  "isFeatured": true,
  "createdAt": "2025-07-20T12:29:15+06:00",
  "updatedAt": "2025-09-03T23:07:45+06:00",
  "imageUrls": [
    "Product\\2c3514a0_b3f2_4536_8da0_19d0681f6e86_1.png",
    "Product\\dad1e32d_6532_11f0_bb1b_a27a3a20c615_2.png",
    "Product\\dad1e32d_6532_11f0_bb1b_a27a3a20c615_3.jpg",
    "Product\\dad1e32d_6532_11f0_bb1b_a27a3a20c615_4.png",
  ],
  "attributes": [
    {
      "name": "Размер: 70",
      "attribute": "Размер",
      "attributeValue": "70",
      "stock": "0",
      "price": "120",
    },
    {
      "name": "Размер: 90",
      "attribute": "Размер",
      "attributeValue": "90",
      "stock": "0",
      "price": "130",
    },
  ],
};
