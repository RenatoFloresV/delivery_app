import 'dart:io';
import 'package:delivery_app/cubit/index..dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../models/index.dart';
import '../snackbar_widgets/snackbar_widgets.dart';
import 'drop_down_button_widget.dart';
import 'forms_add_product.dart';

class AddProductForCategory extends StatefulWidget {
  const AddProductForCategory({Key? key}) : super(key: key);

  @override
  State<AddProductForCategory> createState() => _AddProductForCategoryState();
}

class _AddProductForCategoryState extends State<AddProductForCategory> {
  String? valueChoose;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  String? _category;
  final _picker = ImagePicker();
  File? _selectedImage;

  @override
  void initState() {
    _category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return addProduct(context, state);
      },
    );
  }

  addProduct(context, state) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Material(
        child: Scaffold(
      body: Center(
          child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FormWidget(
                            controller: _nameController,
                            hint: 'Name',
                            label: 'Name'),
                        FormWidget(
                          controller: _priceController,
                          hint: 'Price',
                          label: 'Price',
                          keybordType: TextInputType.number,
                        ),
                        if (_selectedImage != null)
                          SizedBox(
                            height: 150,
                            width: 200,
                            child: Image.file(_selectedImage!),
                          )
                        else
                          IconButton(
                              onPressed: () async {
                                final XFile? photo = await _picker.pickImage(
                                    source: ImageSource.camera);
                                if (photo != null) {
                                  setState(() {
                                    _selectedImage = File(photo.path);
                                  });
                                }
                              },
                              icon: const Icon(Icons.add_a_photo)),
                        DropDownWidget(
                            selectedValue: _category,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                              return null;
                            },
                            onChanged: (String? newValue) {
                              setState(() {
                                _category = newValue!;
                              });
                            }),
                        TextButton(
                            onPressed: () {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                addProductButton(_category);
                              }

                              setState(() {
                                _nameController.text = '';
                                _priceController.text = '';
                                _category = null;
                                _selectedImage = null;
                              });
                            },
                            child: const Text('Add'))
                      ])))),
    ));
  }

  void addProductButton(category) {
    int quantityDefault = 1;
    context.read<ProductsCubit>().addProductForCategory(
        FoodCardModel(
            name: _nameController.text,
            price: _priceController.text,
            // imgUrl: _imageController.text,
            category: category,
            quantity: quantityDefault),
        category,
        _selectedImage);

    ScaffoldMessenger.of(context).showSnackBar(snackBarWhenSuccess(
      'Category ${_nameController.text} added',
    ));
  }
}
