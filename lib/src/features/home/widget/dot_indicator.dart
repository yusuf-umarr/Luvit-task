import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:luvit/src/core/constant/app_color.dart';

class NewPageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final Color indicatorColor;
  final Color selectedIndicatorColor;

  NewPageIndicator({
    required this.currentPage,
    required this.pageCount,
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.blue,
  });

  Widget _buildIndicator(int index, size) {
    // log("index:$index");
    bool isSelected = index == currentPage;
    return Container(
      width: size.width * 0.12,
      height: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelected ? AppColors.primaryColor : AppColors.darkGreyColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // log("pageCount:$pageCount");
    // log("currentPage:$currentPage");
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(pageCount, (index) => _buildIndicator(index, size)),
      ),
    );
  }
}
