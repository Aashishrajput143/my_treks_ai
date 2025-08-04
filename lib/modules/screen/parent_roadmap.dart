
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';
import 'package:vroar/utils/sized_box_extension.dart';

class ParentRoadmapScreen extends ParentWidget {
  const ParentRoadmapScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              centerTitle: true,
              toolbarHeight: 80,
            ),
            body:SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Padding(
                        padding: EdgeInsets.only(top: h*0.05),
                        child: Column(
                            children: [
                              Lottie.asset(appImages.noData),
                              Text(
                                "RoadMap Module Coming Soon",
                                style: TextStyle(
                                  fontSize: 27,
                                  color: appColors.contentAccent,
                                  fontFamily: appFonts.NunitoBold,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              8.kH,
                              Text(
                                "Exciting updates ahead! Our Roadmap module is coming soon, bringing you a clear vision of future features, enhancements, and innovations. Stay tuned for what's next on our journey!",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: appColors.contentPrimary,
                                  fontFamily: appFonts.NunitoMedium,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                      ),
              ),
              ),
    );
  }
}
