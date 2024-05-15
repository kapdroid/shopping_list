import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  AddItemState createState() {
    return AddItemState();
  }
}

class AddItemState extends State<AddItem> {
  @override
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = '1';
  var _selectedType = categories[Categories.vegetables];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(label: Text("Name")),
              validator: (value) {
                if (value == null ||
                    value.trim().length <= 1 ||
                    value.trim().length > 50) {
                  return "value should between 1 to 50 in length";
                }
                return null;
              },
              onSaved: (value) {
                _enteredName = value!;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    maxLength: 8,
                    decoration: const InputDecoration(label: Text("Quantity")),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          int.tryParse(value) == null ||
                          int.tryParse(value)! <= 0) {
                        return "value should greater than zero";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredQuantity = value!;
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: DropdownButtonFormField(
                        value: _selectedType,
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Expanded(
                                  child: Row(children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(category.value.title)
                              ])),
                            )
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value!;
                          });
                        }))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text("Reset")),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.of(context).pop(GroceryItem(
                            id: DateTime.now().toString(),
                            name: _enteredName,
                            category: _selectedType!,
                            quantity: int.parse(_enteredQuantity)));
                      }
                    },
                    child: const Text("Add Item"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
