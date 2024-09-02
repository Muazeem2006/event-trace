import 'package:event_trace/models/Promotion.dart';
import 'package:flutter/material.dart';

class PromotionNotifier extends ChangeNotifier {
  final List<Promotion> _promotionList = [];

  List<Promotion> get promotionList => _promotionList;

  PromotionNotifier() {
    // Initialization logic can be added here.
  }

  // adding promotion
  addPromotion(Promotion promotion) {
    _promotionList.add(promotion);
    notifyListeners();
  }

  // removing promotion
  removePromotion(Promotion promotion) {
    _promotionList.remove(promotion);
    notifyListeners();
  }

  // updating promotion
  void updatePromotion(Promotion updatedPromotion) {
    final index = _promotionList.indexWhere((promotion) => promotion.id == updatedPromotion.id);
    if (index != -1) {
      _promotionList[index] = updatedPromotion;
      notifyListeners();
    }
  }

  // loading promotions from server into the provider
  PromotionNotifier.all(List<Promotion> promotions) {
    _promotionList.addAll(promotions);
    notifyListeners();
  }
}

