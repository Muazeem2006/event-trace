
import 'package:event_trace/models/Category.dart';
import 'package:flutter/material.dart';

class CategoryNotifier extends ChangeNotifier {
  final List<Category> _categoryList = [];

  List<Category> get categoryList => _categoryList;

  CategoryNotifier() {
    // Initialization logic can be added here.
  }

  // adding category
  addCategory(Category category) {
    _categoryList.add(category);
    notifyListeners();
  }

  // removing category
  removeCategory(Category category) {
    _categoryList.remove(category);
    notifyListeners();
  }

  // updating category
  void updateCategory(Category updatedCategory) {
    final index = _categoryList.indexWhere((category) => category.id == updatedCategory.id);
    if (index != -1) {
      _categoryList[index] = updatedCategory;
      notifyListeners();
    }
  }

  // loading categories from server into the provider
  CategoryNotifier.all(List<Category> categories) {
    _categoryList.addAll(categories);
    notifyListeners();
  }
}

