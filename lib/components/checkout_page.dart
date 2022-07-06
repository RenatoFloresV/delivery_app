import 'package:delivery_app/cubit/cart_products/cart_products_cubit.dart';
import 'package:delivery_app/home_screen.dart';
import 'package:delivery_app/models/food_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage(this.products, this.total, this.uid, {Key? key})
      : super(key: key);

  final List<FoodCardModel> products;
  final double total;
  final String uid;

  final String phone = '51936998971';

  @override
  Widget build(BuildContext context) {
    void deleteAllProducts() {
      context.read<CartProductsCubit>().deleteAllProducts(uid);
    }

    return Scaffold(
        body: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text('Checkout'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('Productos: ${products.length}'),
              // Text('Cantidad: ${quantityAll(products)}'),
              Text('Total: S/' ' $total')
            ]),
            actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
              onPressed: () {
                _sendProducts();
                Navigator.of(context).pop();
                deleteAllProducts();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
              child: const Text('Confirm'))
        ]));
  }

  Future<void> _sendProducts() async {
    String pepito = products
            .map((e) =>
                e.name! +
                ', ' +
                'precio S/.${e.price.toString()}' +
                ', ' +
                'cantidad: ${e.quantity.toString()}')
            .join('\n') +
        '\n'
            '\n' +
        'Total: S/.' +
        total.toString();

    final String? url = 'https://wa.me/$phone/?text=$pepito';

    await launch(url!).catchError((onError) => print(onError));
  }

  quantityAll(products) {
    int quantityTotal = 0;
    for (var product in products) {
      quantityTotal += int.parse('${product.quantity}');
    }
    return quantityTotal;
  }
}
