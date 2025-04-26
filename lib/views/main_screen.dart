import 'package:firebaseshop_web/views/sidebar_screens/banners_screen.dart';
import 'package:firebaseshop_web/views/sidebar_screens/buyers_screen.dart';
import 'package:firebaseshop_web/views/sidebar_screens/categories_screen.dart';
import 'package:firebaseshop_web/views/sidebar_screens/order_screen.dart';
import 'package:firebaseshop_web/views/sidebar_screens/product_screen.dart';
import 'package:firebaseshop_web/views/sidebar_screens/vendor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorsScreen();
  screenSelector(item) {
    switch (item.route) {
      case BuyersScreen.id:
        setState(() {
          _selectedScreen = const BuyersScreen();
        });
        break;

      case VendorsScreen.id:
        setState(() {
          _selectedScreen = const VendorsScreen();
        });
        break;

      case OrderScreen.id:
        setState(() {
          _selectedScreen = const OrderScreen();
        });
        break;

      case CategoriesScreen.id:
        setState(() {
          _selectedScreen = const CategoriesScreen();
        });
        break;

      

      case UploadBannerScreen.id:
        setState(() {
          _selectedScreen = const UploadBannerScreen();
        });
        break;

      case ProductScreen.id:
        setState(() {
          _selectedScreen = const ProductScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Management'),
      ),
      sideBar: SideBar(
        header: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
          ),
          height: 50,
          width: double.infinity,
          child: const Center(
            child: Text(
              'TrendlyBuy Admin',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        items: const [
          AdminMenuItem(
              title: 'Vendors',
              route: VendorsScreen.id,
              icon: CupertinoIcons.person_3),
          AdminMenuItem(
              title: 'Buyers',
              route: BuyersScreen.id,
              icon: CupertinoIcons.person),
          AdminMenuItem(
              title: 'Orders',
              route: OrderScreen.id,
              icon: CupertinoIcons.shopping_cart),
         
          AdminMenuItem(
              title: 'Categories',
              route: CategoriesScreen.id,
              icon: CupertinoIcons.list_bullet),
         
          AdminMenuItem(
              title: 'Upload Banners',
              route: UploadBannerScreen.id,
              icon: CupertinoIcons.cloud_upload),
          AdminMenuItem(
              title: 'Products',
              route: ProductScreen.id,
              icon: CupertinoIcons.add),
         
        ],
        selectedRoute: VendorsScreen.id,
        onSelected: (item) {
          screenSelector(item);
        },
      ),
      body: _selectedScreen,
    );
  }
}