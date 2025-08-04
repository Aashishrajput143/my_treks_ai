import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';
import 'package:vroar/utils/sized_box_extension.dart';

import 'common_widgets.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const MyAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
      ),
      actions: actions,
      content: Text(
        content,
        // style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}

class CompactAlertDialog extends StatelessWidget {
  final String message;
  const CompactAlertDialog({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: appColors.alertBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
              child: Text(
                message,
                style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              thickness: 1,
              color: appColors.alertBackgroundBorder,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Close",
                      style: TextStyle(color: appColors.contentAccent, fontSize: 17, fontFamily: appFonts.SpaceGroteskBold, fontWeight: FontWeight.w600),
                    ))),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final double height;
  final String? header;
  const CustomAlertDialog({super.key, required this.height, required this.message, this.header});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: height,
          left: 0,
          right: 0,
          child: Container(
            height: 25,
            width: Platform.isIOS ? 220 : 250,
            margin: const EdgeInsets.symmetric(horizontal: 80),
            decoration: const BoxDecoration(
              color: Colors.red, // Red bottom section
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ),
        Positioned(
          top: height - 190,
          left: 0,
          right: 0,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SizedBox(
              width: 250,
              height: 180,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: header?.isNotEmpty ?? false ? 16 : 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // Aligns the text to the bottom
                  children: [
                    header?.isNotEmpty ?? false
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Text(
                              header ?? "",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: appFonts.NunitoBold,
                                fontWeight: FontWeight.w600,
                                color: appColors.contentPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox(),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: appFonts.NunitoBold,
                        fontWeight: FontWeight.w600,
                        color: appColors.contentPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: height - 208,
          left: 0,
          right: 0,
          child: Center(
            child: SvgPicture.asset(
              appImages.successIcon,
              width: 150,
              height: 150,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomAlertDialogWithTitle extends StatelessWidget {
  final String title;
  final String message;
  final double height;
  const CustomAlertDialogWithTitle({
    super.key,
    required this.height,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: Platform.isIOS ? height * 0.305 : height * 0.347,
          left: 0,
          right: 0,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SizedBox(
              width: 250,
              height: 180,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: appFonts.NunitoBold,
                        fontWeight: FontWeight.w600,
                        color: appColors.contentPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: appFonts.NunitoBold,
                        fontWeight: FontWeight.w600,
                        color: appColors.contentPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: Platform.isIOS ? height * 0.278 : height * 0.32,
          left: 0,
          right: 0,
          child: Center(
            child: SvgPicture.asset(
              appImages.successIcon,
              width: 150,
              height: 150,
            ),
          ),
        ),
        Positioned(
          top: Platform.isIOS ? height * 0.55 : height * 0.59,
          left: 0,
          right: 0,
          child: Container(
            height: 12,
            width: 250,
            margin: const EdgeInsets.symmetric(horizontal: 80),
            decoration: const BoxDecoration(
              color: Colors.red, // Red bottom section
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SuccessDialogBox extends StatelessWidget {
  final String title;
  final String message;
  final double width;
  final String buttonHint;
  final VoidCallback? onChanged;
  const SuccessDialogBox({
    super.key,
    required this.title,
    required this.message,
    required this.width,
    this.onChanged,
    required this.buttonHint,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                appImages.successIconFull,
                width: 190,
                height: 190,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: appColors.contentAccent,
                  fontFamily: appFonts.NunitoBold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: appColors.contentPrimary,
                  fontFamily: appFonts.NunitoMedium,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),
              commonButton(
                double.infinity,
                50,
                appColors.contentAccent,
                Colors.white,
                hint: buttonHint,
                onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventCoinDialogBox extends StatelessWidget {
  final String title;
  final String message;
  final double width;
  final int coin;
  final String buttonHint;
  final String buttonHint2;
  final VoidCallback? onChanged;
  final VoidCallback? onChanged2;
  const EventCoinDialogBox({
    super.key,
    required this.title,
    required this.message,
    required this.coin,
    required this.width,
    this.onChanged,
    this.onChanged2,
    required this.buttonHint,
    required this.buttonHint2,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: width * 0.06),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: appColors.contentPrimary,
                  fontFamily: appFonts.NunitoBold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: appColors.contentPrimary,
                    fontFamily: appFonts.NunitoMedium,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: appColors.contentAccent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SvgPicture.asset(
                          appImages.bigCoins,
                          width: 30,
                          height: 30,
                          fit: BoxFit.fill,
                        ),
                      ),
                      8.kW,
                      Text(
                        '$coin', // your number
                        style: TextStyle(
                          fontSize: 16,
                          color: appColors.contentAccent,
                          fontFamily: appFonts.NunitoMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              commonButton(
                double.infinity,
                45,
                appColors.contentAccent,
                Colors.white,
                hint: buttonHint,
                onChanged,
              ),
              12.kH,
              commonButton(
                double.infinity,
                45,
                Colors.white,
                appColors.contentAccent,
                borderColor: appColors.contentAccent,
                hint: buttonHint2,
                onChanged2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutDialogBox extends StatelessWidget {
  final String title;
  final double width;
  final String goBackHint;
  final String logoutHint;
  final VoidCallback? goBack;
  final VoidCallback? logout;
  const LogoutDialogBox({
    super.key,
    required this.title,
    required this.width,
    this.goBack,
    this.logout,
    required this.goBackHint,
    required this.logoutHint,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                appImages.logoutImage,
                width: 190,
                height: 190,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: appColors.contentPrimary,
                  fontFamily: appFonts.NunitoBold,
                ),
              ),
              const SizedBox(height: 40),
              commonButton(
                double.infinity,
                50,
                appColors.contentAccent,
                Colors.white,
                hint: goBackHint,
                goBack,
              ),
              const SizedBox(
                height: 10,
              ),
              commonButton(
                double.infinity,
                50,
                Colors.white,
                appColors.contentAccent,
                borderColor: appColors.contentAccent,
                hint: logoutHint,
                logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAccountDialogBox extends StatelessWidget {
  final String title;
  final double width;
  final String goBackHint;
  final String deleteAccountHint;
  final VoidCallback? goBack;
  final VoidCallback? deleteAccount;
  const DeleteAccountDialogBox({super.key, required this.title, required this.width, this.goBack, this.deleteAccount, required this.goBackHint, required this.deleteAccountHint});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      insetPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(appImages.deleteIcon, width: 130, height: 130),
              10.kH,
              Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold)),
              25.kH,
              commonButton(double.infinity, 50, appColors.contentAccent, Colors.white, hint: goBackHint, goBack),
              10.kH,
              commonButton(double.infinity, 50, Colors.white, appColors.contentAccent, borderColor: appColors.contentAccent, hint: deleteAccountHint, deleteAccount),
              // 20.kH,
            ],
          ),
        ),
      ),
    );
  }
}
