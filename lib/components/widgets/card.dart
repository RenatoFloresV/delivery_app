import 'package:delivery_app/models/food_card_model.dart';
import 'package:delivery_app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../cubit/index..dart';
import '../../services/auth.dart';

class FoodCard extends StatefulWidget {
  const FoodCard(this.model, this.index, {Key? key}) : super(key: key);

  final List<FoodCardModel> model;
  final int index;

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  List<FoodCardModel> cartProducts = [];

  @override
  void initState() {
    super.initState();
  }

  void _addToCart(BuildContext context, name) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$name añadido al carrito'),
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    AuthService? authService = Provider.of<AuthService>(context);

    void addTestItem(model) {
      context.read<CartProductsCubit>().addProduct(authService.user.uid, model);
      // model.quantity ??= 1;
      // if (model == model) {
      //   model.quantity++;
      //   print(authService.user.uid);
      // }
    }

    // return Text(model[index].id!);

    return Container(
        width: double.infinity,
        height: 300,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: NetworkImage(widget.model[widget.index].imgUrl ?? ''),
                fit: BoxFit.cover)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  // height: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.model[widget.index].name!,
                            style: AppStyle.mainTitleStyle),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('S/${widget.model[widget.index].price!}',
                                  style: AppStyle.priceStyle),
                              IconButton(
                                  onPressed: () {
                                    addTestItem(widget.model[widget.index]);
                                    _addToCart(context,
                                        widget.model[widget.index].name!);
                                  },
                                  icon: const Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.black,
                                  ))
                            ])
                      ]))
            ]));
  }
}
