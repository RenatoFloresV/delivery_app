import 'package:delivery_app/components/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/index.dart';
import 'style/app_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: DrawerWidget()),
      backgroundColor: AppStyle.bgColor,
      appBar: AppBar(
        backgroundColor: AppStyle.bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text('uwu Shop',
            style: GoogleFonts.nunito(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: AppStyle.primaryColor,
            )),
        actions: [ShoppingCart()],
      ),
      body: ListFood(),
    );
  }
}
