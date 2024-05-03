import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luvit/src/core/common_widget/widget.dart';
import 'package:luvit/src/core/constant/app_color.dart';
import 'package:luvit/src/features/home/widget/home_widget.dart';
import 'package:luvit/src/provider/provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color caughtColor = Colors.red;

  @override
  void initState() {
    context.read<SwipeProvider>().loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final providerRead = context.read<SwipeProvider>();
    final providerWatch = context.watch<SwipeProvider>();

    bool isLeftBottom = false;

    return Scaffold(
      appBar: AppBar(
        title: appBarWidget(),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.black,
              AppColors.darkGreyColor,
            ],
          ),
        ),
        width: size.width,
        child: Builder(builder: (context) {
          if (providerWatch.pages.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                child: Center(child: Text("110 No Cards")),
              ),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Draggable(
                onDraggableCanceled: (velocity, offset) {
                  if (offset.dx <= -100 || offset.dy >= 100) {
                    providerRead.removeCurrentPage();
                  }

                  setState(() {});
                },
                feedback: Builder(builder: (context) {
                  return Card(
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                        height: size.height * 0.72,
                        width: size.width * 0.9,
                        child: HomeWidget(
                          swipeImage: providerWatch.removedImg,
                        )),
                  );
                }),
                child: Consumer<SwipeProvider>(builder: (context, val, _) {
                  return Stack(
                    children: [
                      SizedBox(
                        height: size.height * 0.72,
                        child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: val.controller,
                            onPageChanged: val.setCurrentIndex,
                            itemCount: val.pages.length,
                            itemBuilder: (context, index) {
                              var page = val.pages[index];
                              return HomeWidget(
                                swipeImage: page.imageAsset,
                                id: page.id,
                              );
                            }),
                      ),
                      //left
                      if (providerWatch.currentIndex == 0)
                        const SizedBox()
                      else
                        Positioned(
                          top: 0,
                          left: size.width * -0.86,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey),
                            child: SizedBox(
                              height: size.height * 0.72,
                              width: size.width * 0.9,
                              child: const Text(""),
                            ),
                          ),
                        ),
                      //right
                      if (providerWatch.isLastPage)
                        const SizedBox()
                      else
                        Positioned(
                          top: 0,
                          right: size.width * -0.86,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey),
                            child: SizedBox(
                              height: size.height * 0.72,
                              width: size.width * 0.9,
                              child: const Text(""),
                            ),
                          ),
                        )
                    ],
                  );
                }),
              ),
            ],
          );

          ///
        }),
      ),
    );
  }

  Row appBarWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/locationIcon.svg",
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "목이길어슬픈기린님의 새로운 스팟",
              style: TextStyle(fontSize: 11, color: AppColors.whiteColor),
            ),
          ],
        ),
        Row(
          children: [
            CommonWidget.ratingCard(),
            const SizedBox(
              width: 5,
            ),
            SvgPicture.asset(
              "assets/notification.svg",
            )
          ],
        ),
      ],
    );
  }
}
