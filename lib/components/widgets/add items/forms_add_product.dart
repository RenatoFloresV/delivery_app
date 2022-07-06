import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormWidget extends StatelessWidget {
  FormWidget(
      {Key? key,
      required this.controller,
      this.hint,
      this.label,
      this.keybordType})
      : super(key: key);
  TextEditingController controller = TextEditingController();
  String? hint;
  String? label;
  TextInputType? keybordType;
  @override
  Widget build(BuildContext context) {
    validator(value) {
      if (value == null || value.trim().isEmpty) {
        return 'Este campo es obligatorio';
      }
      return null;
    }

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormField(builder: (FormFieldState state) {
          return InputDecorator(
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(color: Colors.black),
                errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: hint,
                errorText: state.hasError ? state.errorText : null,
              ),
              isEmpty: controller.text.isEmpty,
              child: TextFormField(
                controller: controller,
                onChanged: (String? value) {
                  state.didChange(value);
                },
                validator: validator,
                keyboardType: keybordType,
              ));
        }));
  }
}
