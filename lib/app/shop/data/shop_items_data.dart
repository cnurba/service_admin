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
    imageUrl: 'assets/img/img-category.jpeg',
    screen: const CategoryListScreen(),
  ),
  ShopItem(
    title: 'Производители',
    imageUrl: 'assets/img/img-brand.jpeg',
    screen: const BrandListScreen(),
  ),
  ShopItem(
    title: 'Магазины',
    imageUrl: 'assets/img/img-branch.jpg',
    screen: const BranchListScreen(),
  ),
  ShopItem(
    title: 'Товары',
    imageUrl: 'assets/img/img-products.jpg',
    screen: const MyProductsList(),
  ),
  ShopItem(
    title: 'Цены',
    imageUrl: 'assets/img/img-price.jpeg',
    screen: const PriceListScreen(),
  ),
  ShopItem(
    title: 'Остатки',
    imageUrl: 'assets/img/img-stock.jpeg',
    screen: const StockListScreen(),
  ),
];
