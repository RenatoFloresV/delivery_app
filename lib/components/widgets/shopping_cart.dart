import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../cubit/index..dart';
import '../../models/food_card_model.dart';
import '../../services/auth.dart';
import '../../style/app_style.dart';
import '../index.dart';

// ignore: must_be_immutable
class ShoppingCart extends StatefulWidget {
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
  ShoppingCart({Key? key}) : super(key: key);

  List<FoodCardModel> productsCart = [];
  String? uid;
}

class _ShoppingCartState extends State<ShoppingCart> {
  int? _quantity;
  dynamic cubitData;
  @override
  void initState() {
    cubitData = context.read<CartProductsCubit>();
    widget.uid = Provider.of<AuthService>(context, listen: false).user.uid;
    cubitData.loadCartProducts(widget.uid);
    super.initState();
    _quantity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartProductsCubit, CartProductsState>(
      listener: createListener,
      builder: listCardProducts,
    );
  }

  Widget listCardProducts(context, state) {
    if (state is CartProductsLoaded) {
      widget.productsCart = state.cartProducts;
      return GestureDetector(
          child: Stack(alignment: Alignment.center, children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child:
                    Icon(Icons.shopping_cart, size: 30, color: Colors.black)),
            if (widget.productsCart.isNotEmpty)
              Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: CircleAvatar(
                          radius: 9,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Center(
                              child: Text(
                            widget.productsCart.length.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          )))))
          ]),
          onTap: () {
            if (widget.productsCart.isNotEmpty) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _cartWidget(widget.productsCart)));
            }
          });
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  _cartWidget(products) {
    final ValueNotifier<int> _counter = ValueNotifier(products.length);
    return Material(
        child: Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _counter,
          builder: (context, value, child) {
            value = _counter.value;
            if (value == 0) {
              return Center(
                  child:
                      Text('No items in cart', style: AppStyle.mainTitleStyle));
            } else {
              return ListView(children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ListView.builder(
                        itemCount: _counter.value,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  height: 100,
                                  child: Row(children: [
                                    Container(
                                        constraints:
                                            const BoxConstraints(minWidth: 150),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                                products[index].imgUrl,
                                                fit: BoxFit.cover))),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(products[index].name!,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                    'Precio S/ '
                                                    '${products[index].price.toString()}',
                                                    style:
                                                        AppStyle.subTitleStyle),
                                                IconButton(
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      deleteItem(
                                                          widget.uid,
                                                          widget.productsCart[
                                                              index]);
                                                      products.remove(
                                                          products[index]);
                                                      setState(() {
                                                        _counter.value =
                                                            products.length;
                                                      });
                                                    })
                                              ])
                                        ])
                                  ])));
                        })),
                priceTotal(products)
              ]);
            }
          }),
    ));
  }

  priceTotal(products) {
    double total = 0;
    for (var i = 0; i < products.length; i++) {
      total += double.parse(products[i].price) * products[i].quantity;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Precio total:', style: AppStyle.subTitleStyle),
        Text('S/' '$total', style: AppStyle.mainTitleStyle),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CheckoutPage(products, total, widget.uid!)));
          },
          child: Text('Pagar', style: AppStyle.mainTitleStyle),
        )
      ],
    );
  }

  void deleteItem(uid, product) {
    context.read<CartProductsCubit>().deleteProduct(uid, product.id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${product.name} deleted'),
      duration: const Duration(seconds: 1),
    ));
  }

  void createListener(BuildContext context, CartProductsState state) {
    if (state is CartProductsError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.error)));
    }
  }
}
