
import 'package:event_trace/models/Faq.dart';
import 'package:flutter/material.dart';

class FaqNotifier extends ChangeNotifier {
  final List<Faq> _faqList = [];

  List<Faq> get faqList => _faqList;

  FaqNotifier() {
    // Initialization logic can be added here.
  }

  // adding faq
  addFaq(Faq faq) {
    _faqList.add(faq);
    notifyListeners();
  }

  // removing faq
  removeFaq(Faq faq) {
    _faqList.remove(faq);
    notifyListeners();
  }

  // updating faq
  void updateFaq(Faq updatedFaq) {
    final index = _faqList.indexWhere((faq) => faq.id == updatedFaq.id);
    if (index != -1) {
      _faqList[index] = updatedFaq;
      notifyListeners();
    }
  }

  // loading faqs from server into the provider
  FaqNotifier.all(List<Faq> faqs) {
    _faqList.addAll(faqs);
    notifyListeners();
  }
}

