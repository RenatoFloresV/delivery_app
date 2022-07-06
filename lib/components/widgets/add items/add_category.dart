import 'package:delivery_app/models/categorys_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/index..dart';
import '../snackbar_widgets/snackbar_widgets.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _nameController = TextEditingController();

  List<CategoryModel> _categories = [];

  @override
  Widget build(BuildContext context) {
    return categoriesList();
  }

  // void _addCategory(BuildContext context, String name) {
  //   final newCategory = CategoryModel(
  //     categoryName: name,
  //   );
  //   context.read<CategoriesCubit>().addCategory(newCategory);
  // }

  void _deleteCategory(id) {
    context.read<CategoriesCubit>().deleteCategory(id);
    ScaffoldMessenger.of(context).showSnackBar(
      snackBarWhenFailure(snackBarFailureText: 'Categoy $id deleted'),
    );
  }

  void add(id) {
    context.read<CategoriesCubit>().add(id);
    ScaffoldMessenger.of(context).showSnackBar(snackBarWhenSuccess(
      'Category $id added',
    ));
  }

  categoriesList() {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
      if (state is CategoriesLoaded) {
        _categories = state.categories;
      }
      return Scaffold(
          appBar: AppBar(
            title: const Text('Add Category'),
          ),
          body: Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Category Name',
                  ),
                ),
                TextButton(
                  child: const Text('Add Category'),
                  onPressed: () {
                    if (_nameController.text.isNotEmpty) {
                      add(_nameController.text);
                      _nameController.clear();
                    }
                  },
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: _categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                Text(_categories[index].categoryName!),
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        dialog(context, _categories[index].id))
                              ]));
                        }))
              ])));
    });
  }

  dialog(context, id) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Delete Category'),
                content: const Text(
                    'Are you sure you want to delete this category?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                      child: const Text('Delete'),
                      onPressed: () {
                        _deleteCategory(id);
                        Navigator.of(context).pop();
                      })
                ]));
  }
}
