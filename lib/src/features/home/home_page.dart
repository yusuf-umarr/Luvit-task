import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luvit/src/core/common_widget/widget.dart';
import 'package:luvit/src/core/constant/app_color.dart';
import 'package:luvit/src/features/home/widget.dart';
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
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                child: Container(
                  child: Center(child: Text("110 No Cards")),
                ),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Draggable(
                onDraggableCanceled: (velocity, offset) {
                  if (offset.dx < 0 && offset.dy > 0) {
                    providerRead.removeCurrentPage(providerWatch.currentIndex);
                    print("Dragged to left and bottom!");
                  }
                },
                feedback: Card(
                  child: SizedBox(
                    height: size.height * 0.72,
                    child: Center(
                      child: providerWatch.pages[providerWatch.currentIndex],
                    ),
                  ),
                ),
                child: SizedBox(
                  height: size.height * 0.72,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: providerWatch.controller,
                    onPageChanged: (index) {
                      setState(() {
                        providerWatch.currentIndex = index;

                        providerRead.setCurrentIndex(index);
                      });
                    },
                    children: providerWatch.pages,
                  ),
                ),
              ),
            ],
          );
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
