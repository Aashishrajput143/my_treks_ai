import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vroar/common/common_widgets.dart';
import 'package:vroar/resources/colors.dart';

import '../resources/component/authentication_exception.dart';
import '../resources/component/general_exception.dart';
import '../resources/component/internet_exception_widget.dart';

Visibility progressBar(value, h, w) {
  return Visibility(
    visible: value,
    child: Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.black.withOpacity(0.6),
          Colors.black.withOpacity(0.8),
        ],
      )),
      child: Center(
          child: LoadingAnimationWidget.dotsTriangle(
        color: Color(appColors.colorPrimaryNew),
        size: h * 0.05,
      )),
    ),
  );
}

Visibility progressWhiteBar(value, h, w) {
  return Visibility(
    visible: value,
    child: Container(
      height: h,
      width: w,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white60,
              Colors.white60,
            ],
          )),
      child: Center(
          child: LoadingAnimationWidget.dotsTriangle(
            color: Color(appColors.colorPrimaryNew),
            size: h * 0.05,
          )),
    ),
  );
}

Visibility progressBarTransparent(value, h, w) {
  return Visibility(
    visible: value,
    child: Container(
      height: h,
      width: w,
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
          backgroundColor: Colors.transparent,
        ),
      ),
    ),
  );
}

Visibility customProgressBarTransparent(value, h, w) {
  return Visibility(
    visible: value,
    child: Container(
      height: h,
      width: w,
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: Center(
          child: LoadingAnimationWidget.dotsTriangle(
            color: Color(appColors.colorPrimaryNew),
            size: h * 0.05,
          )),
    ),
  );
}

Visibility internetException(value, onPress) {
  return Visibility(
      visible: value,
      child: InternetExceptionWidget(
        onPress: onPress,
      ));
}

Visibility generalException(value, onPress) {
  return Visibility(
      visible: value,
      child: GeneralExceptionWidget(
        onPress: onPress,
      ));
}

Visibility authentication(value) {
  return Visibility(visible: value, child: AuthenticationExceptionWidget());
}

Widget shimmerEffect(
  bool value,
  var h,
) {
  return Visibility(
    visible: value,
    child: Container(
      margin: edgeInsetsOnly(top: 55),
      height: h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5, // Adjust the number of shimmer items as needed
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.transparent, // Change to transparent to better show blur
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4.0,
                    offset: const Offset(0, 2), // Shadow position
                  ),
                ],
              ),
              height: 220, // Height of the shimmer card
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur effect
                  child: Container(
                    color: Colors.white.withOpacity(0.1), // Set lower opacity for better blur visibility
                    padding: const EdgeInsets.all(16.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitlePlaceholder(width: double.infinity),
                        SizedBox(height: 8.0),
                        ContentPlaceholder(lineType: ContentLineType.threeLines),
                        SizedBox(height: .0),
                        TitlePlaceholder(width: 100.0),
                        SizedBox(height: 8.0),
                        ContentPlaceholder(lineType: ContentLineType.twoLines),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

Widget shimmerEffectProfile(
  bool value,
  var h,
) {
  return Visibility(
    visible: value,
    child: SizedBox(
      height: h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5, // Adjust the number of shimmer items as needed
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.transparent, // Change to transparent to better show blur
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4.0,
                    offset: const Offset(0, 2), // Shadow position
                  ),
                ],
              ),
              height: 160, // Height of the shimmer card
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur effect
                  child: Container(
                    color: Colors.white.withOpacity(0.1), // Set lower opacity for better blur visibility
                    padding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 20.0,
      color: Colors.white,
    );
  }
}

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({super.key, required this.lineType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lineType == ContentLineType.twoLines ? 2 : 3, (index) {
        return Container(
          width: double.infinity,
          height: 15.0,
          margin: const EdgeInsets.only(bottom: 8.0),
          color: Colors.white,
        );
      }),
    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}
