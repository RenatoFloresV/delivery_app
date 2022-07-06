import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/index..dart';
import '../models/index.dart';
import '../style/app_style.dart';
import 'index.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List<FoodCardModel> products = [];
  String? category;
  @override
  void initState() {
    context.read<CategoriesCubit>().getCategories();
    category = 'awa';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(builder: categoryList);
  }

  Widget categoryList(context, state) {
    if (state is CategoriesInitial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is CategoriesLoaded) {
      final categories = state.categories;

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Categories',
                textAlign: TextAlign.left,
                style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: AppStyle.primaryColor))),
        SizedBox(
          height: 60,
          child: ListView.builder(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => Container(
                  margin: const EdgeInsets.all(10),
                  child: ActionChip(
                      label: Text(state.categories[index].categoryName!),
                      onPressed: () {
                        setState(() {
                          category = state.categories[index].categoryName!;
                        });
                      }))),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$category',
                textAlign: TextAlign.left,
                style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: AppStyle.primaryColor))),
        ProductsForCategory(category: category!)
      ]);
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
