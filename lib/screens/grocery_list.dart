import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/add_items.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GroceryListState();
  }
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No items added yet."),
    );
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (ctx, index) {
            return Dismissible(key: ValueKey(_groceryItems[index].id), child: ListTile(
              title: Text(_groceryItems[index].name),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItems[index].category.color,
              ),
              trailing: Text(_groceryItems[index].quantity.toString()),
            ),onDismissed: (direction){
              setState(() {
                  _groceryItems.remove(_groceryItems[index]);
                });
            },);
          });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
              onPressed: () {
                _goToAddItem();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: content,);
  }

  void _goToAddItem() async {
    var result = await Navigator.of(context)
        .push<GroceryItem>(MaterialPageRoute(builder: (ctx) => AddItem()));
    if (result == null) return;
    setState(() {
      _groceryItems.add(result);
    });
  }
}
