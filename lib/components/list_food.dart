import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/index..dart';
import '../models/index.dart';
import '../style/app_style.dart';
import 'index.dart';

// ignore: must_be_immutable
class ListFood extends StatefulWidget {
  ListFood({Key? key}) : super(key: key);
  List<FoodCardModel> foodCardModel = [];

  @override
  State<ListFood> createState() => _ListFoodState();
}

class _ListFoodState extends State<ListFood> {
  @override
  void initState() {
    context.read<ProductsCubit>().loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(builder: listCategories);
  }

  Widget listCategories(context, state) {
    if (state is ProductsLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const SingleChildScrollView(child:  CategoriesList());
    }
  }

  listProducts(state) {
    if (state is ProductsLoaded) {
      if (state.products.isEmpty) {
        return Center(
          child: Text('No hay productos disponibles',
              style: AppStyle.subTitleStyle),
        );
      }
      final product = state.products;
      widget.foodCardModel = product;
      return GridView.builder(
        itemCount: product.length,
        itemBuilder: (context, index) => FoodCard(product, index),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500, crossAxisSpacing: 16),
      );
    } else {
      return const Center(child: Text('No Products'));
    }
  }
}
