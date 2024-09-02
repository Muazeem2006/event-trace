// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:developer';

import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/controllers/category_notifier.dart';
import 'package:event_trace/models/Category.dart';
import 'package:event_trace/services/request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool loading = true;

  Future<void> fetchCategories(BuildContext context) async {
    final response = await getRequest('categories', null);
    try {
      response.data['categories']
          .map<Category>((categoryJson) => Category.fromMap(categoryJson))
          .where((category) => !context
              .read<CategoryNotifier>()
              .categoryList
              .any((c) => c.id == category.id))
          .forEach((category) =>
              context.read<CategoryNotifier>().addCategory(category));
    } catch (e) {
      triggerToast(
        context,
        'Failed to fetch categories',
        Colors.red,
        Colors.white,
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fetchCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    void openDrawer() {
      Scaffold.of(context).openDrawer();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: openDrawer,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text(
          'Categories',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<CategoryNotifier>(
              builder: (context, categoryNotifier, child) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categoryNotifier.categoryList.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final category = categoryNotifier.categoryList[index];
                    return Card(
                      elevation: 3,
                      child: GestureDetector(
                        onTap: () {
                          // categoryNotifier
                        },
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.white,
                          trailing: PopupMenuButton<int>(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 1,
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: Text('Delete'),
                              ),
                            ],
                            onSelected: (value) {
                              switch (value) {
                                case 1:
                                  log('Edit ${category.name}');
                                  break;
                                case 2:
                                  log('Delete ${category.name}');
                                  break;
                                default:
                                  log('Default');
                                  break;
                              }
                            },
                          ),
                          title: Text(
                            category.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          subtitle: Text(
                            category.description!,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
