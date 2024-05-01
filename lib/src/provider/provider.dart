import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:luvit/src/features/home/widget.dart';

class SwipeProvider with ChangeNotifier {
  final controller = PageController(initialPage: 0);
  int currentIndex = 0;
  int navbarIndex = 0;

  bool get isLastPage => currentIndex == pages.length - 1;

  bool get isFirstPage => currentIndex == pages.first;

  List<Widget> pages = [];

  setCurrentIndex(index) {
    currentIndex = index;

    notifyListeners();
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
    pages = <Widget>[
      HomeWidget(
        prevOntap: () {
          prevBtn();
        },
        nextOntap: () {
          nextBtn();
        },
        swipeImage: "assets/101_Main_Profile01.png",
      ),
      HomeWidget(
        prevOntap: () {
          prevBtn();
        },
        nextOntap: () {
          nextBtn();
        },
        swipeImage: "assets/102_Main_Profile02.png",
      ),
      HomeWidget(
        prevOntap: () {
          prevBtn();
        },
        nextOntap: () {
          nextBtn();
        },
        swipeImage: "assets/103_Main_Profile03.png",
      ),
      HomeWidget(
        prevOntap: () {
          prevBtn();
        },
        nextOntap: () {
          nextBtn();
        },
        swipeImage: "assets/103_Main_Profile03.png",
      ),
      HomeWidget(
        prevOntap: () {
          prevBtn();
        },
        nextOntap: () {
          nextBtn();
        },
        swipeImage: "assets/103_Main_Profile03.png",
      ),
    ];
  }

  removeCurrentPage(index) {
    log("curent index $index");
    pages.removeAt(index);

    log("pages total:${pages.length}");
    notifyListeners();
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
