import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:luvit/src/features/home/models/home_model.dart';

class SwipeProvider with ChangeNotifier {
  final controller = PageController(initialPage: 0);
  int currentIndex = 0;
  int modelId = 0;
  int navbarIndex = 0;
  bool get isLastPage => currentIndex == pages.length - 1;

  bool get isFirstPage => currentIndex == pages.first;

  List pages = [];

  setCurrentIndex(index) {
    currentIndex = index;
    notifyListeners();
  }

  setModelId(index) {
    if (index != null) {
      modelId = index;
    }
  }

  void nextBtn() {
    isLastPage
        ? {log("this is last page=======")}
        : controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
    notifyListeners();
  }

  void prevBtn() {
    isFirstPage
        ? {log("this is first page=======")}
        : controller.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
    notifyListeners();
  }

  void loadPage() {
    pages = [
      HomeModel("assets/101_Main_Profile01.png", 0),
      HomeModel("assets/102_Main_Profile02.png", 1),
      HomeModel("assets/103_Main_Profile03.png", 2),
      HomeModel("assets/103_Main_Profile03.png", 3),
      HomeModel("assets/103_Main_Profile03.png", 4),
    ];
  }

  removeCurrentPage() {
    pages.removeWhere((element) => element.id == modelId);
  }

  setNavbarIndex(index) {
    navbarIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}
