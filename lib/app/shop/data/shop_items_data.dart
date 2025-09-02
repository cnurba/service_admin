import 'package:service_admin/app/shop/branches/presentation/list/branch_list_screen.dart';
import 'package:service_admin/app/shop/brands/presentation/list/brand_list_screen.dart';
import 'package:service_admin/app/shop/categories/presentation/list/category_list_screen.dart';
import 'package:service_admin/app/shop/price/presentation/price_list_screen.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/my_products_list.dart';
import 'package:service_admin/app/shop/shop_item.dart';
import 'package:service_admin/app/shop/stock/presentation/stock_list_screen.dart';

final List<ShopItem> ShopItems = [
  ShopItem(
    title: 'Категории',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJxlgcNJXH-rLajyTv-_kn5Sc_gTdc6fxz5w&s',
    screen: const CategoryListScreen(),
  ),
  ShopItem(
    title: 'Производители',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNOMEET0WeihdqQr0qK82RrT6Q4KcxVRSnAQ&s',
    screen: const BrandListScreen(),
  ),
  ShopItem(
    title: 'Магазины',
    imageUrl:
        'https://www.stroymag-bishkek.com/wp-content/uploads/2021/11/banner2021.jpg',
    screen: const BranchListScreen(),
  ),
  ShopItem(
    title: 'Товары',
    imageUrl:
        'https://lh4.googleusercontent.com/proxy/H-vN6uymeA3juibhRzk6iM8tIr7E-s8WZqWilj7MkwjHaRAxCBJhxvVlLaGZKiinwjOf8Qwg0Ixlk56cPnmq8MlCeZW1dKDYygmbecb0CZmxjMCG8oUxzoUo6Yglnf2d2Jwgk-LLaEiIHTYkQ0h9dngtvCAEvP2WnR5-bixIO-Q79g',
    screen: const MyProductsList(),
  ),
  ShopItem(
    title: 'Цены',
    imageUrl: 'https://images.unsplash.com/photo-1561414927-6d86591d0c4f',
    screen: const PriceListScreen(),
  ),
  ShopItem(
    title: 'Остатки',
    imageUrl: 'https://www.extensiv.com/hubfs/AdobeStock_181658575.jpeg',
    screen: const StockListScreen(),
  ),
];
