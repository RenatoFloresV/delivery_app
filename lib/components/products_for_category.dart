import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/index..dart';
import '../models/index.dart';
import 'index.dart';

class ProductsForCategory extends StatefulWidget {
  const ProductsForCategory({Key? key, required this.category})
      : super(key: key);

  final String category;

  @override
  State<ProductsForCategory> createState() => _ProductsForCategoryState();
}

class _ProductsForCategoryState extends State<ProductsForCategory> {
  List<FoodCardModel> filterForProductsForCategory = [];

  @override
  void initState() {
    context.read<ProductsCubit>().productForCategory(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child:
        BlocBuilder<ProductsCubit, ProductsState>(builder: (context, state) {
      if (state is ProductsLoaded) {
        filterForProductsForCategory = (state).products;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filterForProductsForCategory.length,
            itemBuilder: (context, index) =>
                FoodCard(filterForProductsForCategory, index),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500, crossAxisSpacing: 16),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }));
  }
}
