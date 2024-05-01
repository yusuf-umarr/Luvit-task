import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luvit/src/core/common_widget/widget.dart';
import 'package:luvit/src/core/constant/app_color.dart';
import 'package:luvit/src/features/home/widget/dot_indicator.dart';
import 'package:luvit/src/provider/provider.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  final String swipeImage;

  const HomeWidget({
    required this.swipeImage,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<SwipeProvider>();
    final providerRead = context.read<SwipeProvider>();

    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(swipeImage),
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.darkGreyColor),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    userDetailCard(context),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppColors.whiteColor,
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: InkWell(
                onTap: () {
                  providerRead.prevBtn();
                },
                child: Container(
                  width: size.width * 0.25,
                  height: size.height * 0.055,
                  color: Colors.transparent,
                  child: const Text(""),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                onTap: () {
                  providerRead.nextBtn();
                },
                child: Container(
                  width: size.width * 0.25,
                  height: size.height * 0.055,
                  color: Colors.transparent,
                  child: const Text(""),
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: NewPageIndicator(
                    currentPage: providerWatch.currentIndex,
                    pageCount: providerWatch
                        .pages.length, // Replace with your total page count
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox userDetailCard(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.77,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonWidget.ratingCard(
                      boderColor: AppColors.black,
                      starColor: AppColors.darkGreyColor,
                      text: "29,930"),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "잭과분홍콩나물",
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 7),
                    child: Text(
                      "25",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "서울 ",
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  Text(
                    ". 2km 거리에 있음 ",
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ],
              )
            ],
          ),
          SvgPicture.asset(
            "assets/favouriteIcon.svg",
          )
        ],
      ),
    );
  }
}
