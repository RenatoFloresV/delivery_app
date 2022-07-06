import 'package:delivery_app/cubit/categories/categories_cubit.dart';
import 'package:delivery_app/models/categorys_model.dart';
import 'package:delivery_app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class DropDownWidget extends StatefulWidget {
  DropDownWidget(
      {Key? key,
      required this.selectedValue,
      required this.onChanged,
      this.validator})
      : super(key: key);
  String? selectedValue;
  Function(String?)? onChanged;
  String? Function(String?)? validator;

  @override
  _DropDownDemoState createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownWidget> {
  List<CategoryModel> _categories = [];

  @override
  void initState() {
    widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
      if (state is CategoriesLoaded) {
        _categories = state.categories;
        if (_categories.isEmpty) {
          return const Center(
            child: Text('No Categories'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: widget.validator,
                style: AppStyle.subTitleStyle,
                iconDisabledColor: AppStyle.primaryColor,
                hint: const Text('Select Category'),
                value: widget.selectedValue,
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.categoryName,
                    child: Text(category.categoryName!),
                  );
                }).toList(),
                onChanged: widget.onChanged,
              ),
            )),
          );
        }
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  // Widget dropDownButton() {
  //   // widget.selectedValue = 'Select Category';
  //   return DropdownButtonHideUnderline(
  //     child: DropdownButton<String>(
  //       style: AppStyle.subTitleStyle,
  //       iconDisabledColor: AppStyle.primaryColor,
  //       hint: const Text('Select Category'),
  //       value: widget.selectedValue,
  //       items: _categories.map((category) {
  //         return DropdownMenuItem<String>(
  //           value: category.categoryName,
  //           child: Text(category.categoryName!),
  //         );
  //       }).toList(),
  //       onChanged: (String? newValue) {
  //         setState(() {
  //           widget.selectedValue = newValue!;
  //         });
  //       },
  //     ),
  //   );
  // }
}
