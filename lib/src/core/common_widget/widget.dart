import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luvit/src/core/constant/app_color.dart';

class CommonWidget {
  static Container ratingCard({
    boderColor = AppColors.darkGreyColor,
    starColor = AppColors.primaryColor,
    text = "323,233",
  }) {
    return Container(
      padding: const EdgeInsets.all(4).copyWith(left: 8, right: 8),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.greyColor.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/starIcon.svg",
            colorFilter: ColorFilter.mode(starColor, BlendMode.srcIn),
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: AppColors.whiteColor),
          )
        ],
      ),
    );
  }

//
}
