import 'package:delivery_app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth.dart';
import 'add items/add_category.dart';
import 'add items/add_product_for_category.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Bienvenido ${authService.user.displayName}'),
            accountEmail: Text('${authService.user.email}'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                authService.user.photoURL!,
              ),
            ),
            decoration: BoxDecoration(
              color: AppStyle.primaryColor,
            ),
          ),
          ListTile(
            title: const Text('Add Category'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddCategory(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Add Product'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddProductForCategory(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              authService.signOut();
            },
          ),
        ],
      ),
    );
  }
}
