import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:readmore/readmore.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/utils/sized_box_extension.dart';

import '../resources/font.dart';
import '../resources/formatter.dart';
import '../resources/images.dart';
import '../resources/strings.dart';

Future bottomDrawer(
  context,
  h,
  w,
  String? selectedImage,
  void Function()? onImageGallery,
  void Function()? onCamera,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: h,
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Text(
                appStrings.uploadPhoto,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: appFonts.NunitoBold,
                    color: appColors.contentPrimary),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: onImageGallery,
                child: Row(
                  children: [
                    Image.asset(
                      appImages.imageGalleryIcon,
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      appStrings.viewPhotoLibrary,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: appFonts.NunitoRegular,
                          fontWeight: FontWeight.w600,
                          color: appColors.contentSecondary),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: onCamera,
                child: Row(
                  children: [
                    Image.asset(
                      appImages.cameraIcon,
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      appStrings.takeAPhoto,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: appFonts.NunitoRegular,
                          fontWeight: FontWeight.w600,
                          color: appColors.contentSecondary),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (selectedImage?.isNotEmpty ?? false) {
                    Navigator.pop(context);
                    selectedImage = null;
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: selectedImage?.isNotEmpty ?? false
                      ? Colors.white
                      : appColors.buttonStateDisabled,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: selectedImage?.isNotEmpty ?? false
                          ? appColors.contentAccent
                          : appColors.buttonStateDisabled,
                      width: 1.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      appImages.deleteIcon,
                      width: 25,
                      height: 25,
                      color: selectedImage?.isNotEmpty ?? false
                          ? appColors.contentAccent
                          : appColors.buttonTextStateDisabled,
                    ),
                    Text(
                      appStrings.removePhoto,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: appFonts.NunitoMedium,
                        fontWeight: FontWeight.w600,
                        color: selectedImage?.isNotEmpty ?? false
                            ? appColors.contentAccent
                            : appColors.buttonTextStateDisabled,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

backButton(
  void Function()? onTap, {
  double? top = 40,
  double? left = 10,
}) {
  return Positioned(
    top: top,
    left: left,
    child: InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        width: 60,
        height: 50,
        child: Center(
            child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: appColors.contentPrimary,
        )),
      ),
    ),
  );
}

Future bottomCodeDrawer(
    TextEditingController controller,
    FocusNode focusNode,
    RxString couponCode,
    error,
    Rx<bool> isLoading,
    void Function(String)? onChanged,
    void Function()? submit,
    ) {
  return Get.bottomSheet(
    WillPopScope(
      onWillPop: () async => !isLoading.value,
      child: Obx(
            () => GestureDetector(
          onVerticalDragDown: isLoading.value ? (_) {} : null,
          child: AbsorbPointer(
            absorbing: isLoading.value,
            child: Container(
              height: error.value == null ? 220 : 260,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                        right: Radius.circular(10),
                      ),
                    ),
                  ),
                  40.kH,
                  commonTextField(
                    controller,
                    focusNode,
                    inputFormatters: [
                      NoSpaceTextInputFormatter()
                    ],
                    double.infinity,
                    onChange: onChanged,
                        (value) {},
                    readonly: isLoading.value,
                    hint: "Enter Coupon Code",
                    error: error.value,
                  ),
                  20.kH,
              commonButtonWithLoader(
                double.infinity,
                50,
                couponCode.value != ""
                    ? appColors.contentAccent
                    : appColors.buttonStateDisabled,
                couponCode.value != ""
                    ? Colors.white
                    : appColors.buttonTextStateDisabled,
                isLoading,
                submit,
                hint: "Verify Coupon Code"),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    isDismissible: !isLoading.value,
    enableDrag: !isLoading.value,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
  );
}


// Future bottomCodeDrawer(
//   TextEditingController controller,
//   FocusNode focusNode,
//   RxString couponCode,
//   error,
//   Rx<bool> isLoading,
//   void Function(String)? onChanged,
//   void Function()? submit,
// ) {
//   print(error);
//   return Get.bottomSheet(
//     Obx(
//       () => Container(
//         height: error.value == null ? 220 : 260,
//         decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//             color: Colors.white),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               width: 70,
//               height: 6,
//               decoration: BoxDecoration(
//                 color: appColors.border,
//                 borderRadius: const BorderRadius.horizontal(
//                   left: Radius.circular(10),
//                   right: Radius.circular(10),
//                 ),
//               ),
//             ),
//             40.kH,
//             commonTextField(
//                 controller,
//                 focusNode,
//                 double.infinity,
//                 onChange: onChanged,
//                 (value) {},
//                 readonly: isLoading.value,
//                 hint: appStrings.enterCouponCode,
//                 error: error.value),
//             20.kH,
//             commonButtonWithLoader(
//                 double.infinity,
//                 50,
//                 couponCode.value != ""
//                     ? appColors.contentAccent
//                     : appColors.buttonStateDisabled,
//                 couponCode.value != ""
//                     ? Colors.white
//                     : appColors.buttonTextStateDisabled,
//                 isLoading,
//                 submit,
//                 hint: "Verify Coupon Code"),
//           ],
//         ),
//       ),
//     ),
//     isDismissible: !isLoading.value,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(35),
//     ),
//     enableDrag: true,
//   );
// }

Container searchField(
    controller, focusNode, Color color, width, onSubmitted(input),
    {int maxLegth = 30,
    String hint = '',
    bool obscure = false,
    onChange,
    onTap}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(appColors.colorPrimary2),
          Color(appColors.colorPrimary)
        ], // Define your gradient colors here
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(25),
    ),
    padding: const EdgeInsets.all(1), // Create space for the gradient border
    child: Container(
      width: width,
      decoration: BoxDecoration(
        color: color, // Background color for the inner TextField container
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLegth,
        onSubmitted: onSubmitted,
        onChanged: onChange,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: Container(
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset(
              appImages.appIcon,
              height: 14,
              width: 14,
            ),
          ),
          contentPadding: const EdgeInsets.all(15),
          isDense: true,
          hintText: hint,
          hintStyle:
              TextStyle(color: Color(appColors.searchHint), fontSize: 13),
          counterText: "",
          border: InputBorder.none, // Remove the default border
        ),
        maxLines: 1,
        textAlign: TextAlign.start,
        obscureText: obscure,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: appFonts.robotsRegular,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
  );
}

Widget searchFieldWithoutGradient(
  TextEditingController controller,
  FocusNode focusNode,
  Color color,
  double width,
  void Function(String) onSubmitted, {
  int maxLength = 30,
  String hint = '',
  bool obscure = false,
  void Function()? onTap,
  void Function(String)? onChange,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;

      focusNode.addListener(() {
        setState(() {});
      });

      Color borderColor = isHovered || focusNode.hasFocus
          ? Color(appColors.buttonNew)
          : Color(appColors.colorPrimaryNew);

      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: borderColor, width: 1.0),
          ),
          padding: const EdgeInsets.all(1.0),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              controller: controller,
              onTap: onTap,
              focusNode: focusNode,
              onTapOutside: (value) => focusNode.unfocus(),
              maxLength: maxLength,
              onSubmitted: onSubmitted,
              onChanged: onChange,
              inputFormatters: [NoLeadingSpaceFormatter()],
              decoration: InputDecoration(
                prefixIcon: Container(
                  padding: const EdgeInsets.all(13),
                  child: SvgPicture.asset(
                    appImages.appIcon,
                    height: 14,
                    width: 14,
                  ),
                ),
                contentPadding: const EdgeInsets.all(10),
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(
                  color: Color(appColors.searchHint),
                  fontSize: 13,
                ),
                counterText: "",
                border: InputBorder.none,
              ),
              maxLines: 1,
              textAlign: TextAlign.start,
              obscureText: obscure,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: appFonts.robotsRegular,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget commonSearchField(
  TextEditingController controller,
  FocusNode focusNode,
  double width,
  void Function(String) onSubmitted, {
  int maxLength = 254,
  double contentPadding = 12,
  String hint = '',
  dynamic error,
  dynamic maxLines = 1,
  bool readonly = false,
  void Function(String)? onChange,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return SizedBox(
        width: width,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          maxLength: maxLength,
          onSubmitted: onSubmitted,
          onTapOutside: (value) => focusNode.unfocus(),
          onChanged: onChange,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Container(
                padding: EdgeInsets.all(contentPadding),
                child: Icon(
                  Icons.search_sharp,
                  color: appColors.contentPrimary,
                  size: 22,
                )),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(contentPadding),
            // contentPadding: Platform.isIOS
            //     ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
            //     : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            isDense: true,
            hintText: hint,
            hintStyle: TextStyle(
              color: appColors.contentPlaceholderPrimary,
              fontFamily: appFonts.NunitoRegular,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            counterText: "",
            errorText: error,
            errorMaxLines: 2,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appColors.border),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appColors.contentAccent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: appColors.contentAccent, // Red border for errors
                width: 2.0,
              ),
            ),
          ),
          maxLines: maxLines,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: appColors.contentPrimary,
            fontSize: 16,
            fontFamily: appFonts.NunitoRegular,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    },
  );
}

Widget gradientDivider({double height = 2.0}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(appColors.colorPrimaryNew), // Starting color of the gradient
          Color(appColors.searchHint), // Ending color of the gradient
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  );
}

Widget commonProfileWidget(String text, String iconPath, Color textColor,
    Color backgroundColor, VoidCallback onTap) {
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontFamily: appFonts.NunitoRegular,
                    fontWeight: FontWeight.w600)),
          ),
          Icon(Icons.arrow_forward_ios, size: 18, color: textColor),
        ],
      ),
    ),
  );
}

Widget commonProfileNotification(
  String text,
  String iconPath,
  Color iconColor,
  Color textColor,
  bool iEnable,
  Color backgroundColor,
  VoidCallback onTap,
  void Function(bool) onSubmitted,
) {
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontFamily: appFonts.NunitoRegular,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CupertinoSwitch(
            value: iEnable,
            onChanged: onSubmitted,
            activeTrackColor: Colors.green,
            inactiveTrackColor: appColors.buttonTextStateDisabled,
            inactiveThumbColor: Colors.white,
            //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    ),
  );
}

Widget commonProfileWidgetWithoutIcon(
  String text,
  Color textColor,
  Color backgroundColor,
  VoidCallback onTap,
) {
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontFamily: appFonts.NunitoRegular,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: textColor,
          ),
        ],
      ),
    ),
  );
}

Widget emailField(
  TextEditingController controller,
  FocusNode focusNode,
  void Function(String) onSubmitted, {
  int maxLength = 254,
  double contentPadding = 12,
  String hint = '',
  dynamic error,
  bool readonly = false,
  void Function(String)? onChange,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        readOnly: readonly,
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onTapOutside: (value) => focusNode.unfocus(),
        onSubmitted: onSubmitted,
        onChanged: onChange,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(contentPadding),
          // contentPadding: Platform.isIOS
          //     ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
          //     : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: appColors.contentPlaceholderPrimary,
            fontFamily: appFonts.NunitoRegular,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          counterText: "",
          errorText: error,
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.contentAccent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: appColors.contentAccent, // Red border for errors
              width: 2.0,
            ),
          ),
        ),
        maxLines: 1,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: appColors.contentPrimary,
          fontSize: 16,
          fontFamily: appFonts.NunitoRegular,
          fontWeight: FontWeight.w600,
        ),
      );
    },
  );
}

Widget commonReadMoreText(
String hint,
    {
      int trimLine = 5,
      double fontSize = 14,
    }) {
  return StatefulBuilder(
    builder: (context, setState) {
      return ReadMoreText(
        hint,
        style: TextStyle(
          fontSize: fontSize,
          color: appColors.contentSecondary,
          fontFamily: appFonts.NunitoMedium,
          fontWeight: FontWeight.w500,
        ),
        trimLines: trimLine,
        trimMode: TrimMode.Line,
        colorClickableText: appColors.contentAccent,
        trimCollapsedText: appStrings.trimCollapsedText,
        textAlign: TextAlign.justify,
        trimExpandedText: appStrings.trimExpandedText,
        delimiter: '',
        moreStyle: TextStyle(
          color: appColors.contentAccent,
          fontFamily: appFonts.NunitoBold,
          fontWeight: FontWeight.w600,
        ),
        lessStyle: TextStyle(
          color: appColors.contentAccent,
          fontFamily: appFonts.NunitoBold,
          fontWeight: FontWeight.w600,
        ),
      );
    },
  );
}

Widget commonTextField(
  TextEditingController controller,
  FocusNode focusNode,
  double width,
  void Function(String) onSubmitted, {
  int maxLength = 254,
  double contentPadding = 12,
  String hint = '',
  dynamic error,
  dynamic maxLines = 1,
  bool readonly = false,
  void Function(String)? onChange,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.done,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onSubmitted: onSubmitted,
        readOnly: readonly,
        onTapOutside: (value) => focusNode.unfocus(),
        onChanged: onChange,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(contentPadding),
          // contentPadding: Platform.isIOS
          //     ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
          //     : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: appColors.contentPlaceholderPrimary,
            fontFamily: appFonts.NunitoRegular,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          counterText: "",
          errorText: error,
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.contentAccent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: appColors.contentAccent, // Red border for errors
              width: 2.0,
            ),
          ),
        ),
        maxLines: maxLines,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: appColors.contentPrimary,
          fontSize: 16,
          fontFamily: appFonts.NunitoRegular,
          fontWeight: FontWeight.w600,
        ),
      );
    },
  );
}

Widget commonDescriptionTextField(
  TextEditingController controller,
  FocusNode focusNode,
  double width,
  void Function(String) onSubmitted, {
  double contentPadding = 12,
  String hint = '',
  dynamic error,
  maxLines = 1,
  minLines = 1,
  dynamic maxLength = 1000,
  bool readonly = false,
  void Function(String)? onChange,
  TextInputType keyboardType = TextInputType.multiline,
  TextInputAction textInputAction = TextInputAction.newline,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      // Keep track of whether the field is focused
      int maxLinesCalc = focusNode.hasFocus ? minLines : maxLines;

      // Add listener if not already added
      focusNode.addListener(() {
        setState(() {});
      });

      return TextField(
        controller: controller,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        onTapOutside: (value) => focusNode.unfocus(),
        onChanged: onChange,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        readOnly: readonly,
        maxLines: maxLinesCalc,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: appColors.contentPrimary,
          fontSize: 16,
          fontFamily: appFonts.NunitoRegular,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(contentPadding),
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: appColors.contentPlaceholderPrimary,
            fontFamily: appFonts.NunitoRegular,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          counterText: "",
          errorText: error,
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.contentAccent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: appColors.contentAccent,
              width: 2.0,
            ),
          ),
        ),
      );
    },
  );
}

Widget ageTextFiled(
  TextEditingController controller,
  FocusNode focusNode,
  double width, VoidCallback onTap,
  void Function(String) onSubmitted, {
  double contentPadding = 12,
  int maxLength = 2,
  String hint = '',
  dynamic error,List<TextInputFormatter>? inputFormatters,
  bool readonly = false, TextInputType keyboardType = TextInputType.number,
  void Function(String)? onChange,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onTapOutside: (value) => focusNode.unfocus(),
        onSubmitted: onSubmitted,
        onChanged: onChange,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: Icon(
                Icons.calendar_today_sharp,
                size: 22,
                color: appColors.contentPrimary,
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(contentPadding),
// contentPadding: Platform.isIOS
//     ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
//     : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: appColors.contentPlaceholderPrimary,
            fontFamily: appFonts.NunitoRegular,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          counterText: "",
          errorText: error,
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.contentAccent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: appColors.contentAccent, // Red border for errors
              width: 2.0,
            ),
          ),
        ),
        maxLines: 1,
        readOnly: readonly,
        style: TextStyle(
          color: appColors.contentPrimary,
          fontSize: 16,
          fontFamily: appFonts.NunitoRegular,
          fontWeight: FontWeight.w600,
        ),
      );
    },
  );
}

Widget dateOfBirthTextFiled(
  TextEditingController controller,
  FocusNode focusNode,
  double width,
  VoidCallback onTap,
  void Function(String) onSubmitted, {
  double contentPadding = 12,
  int maxLength = 320,
  String hint = '',
  dynamic error,
  bool readonly = false,
  void Function(String)? onChange,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onTapOutside: (value) => focusNode.unfocus(),
        onSubmitted: onSubmitted,
        onTap: onTap,
        onChanged: onChange,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: Icon(
                Icons.calendar_today_sharp,
                size: 22,
                color: appColors.contentPrimary,
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(contentPadding),
// contentPadding: Platform.isIOS
//     ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
//     : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: appColors.contentPlaceholderPrimary,
            fontFamily: appFonts.NunitoRegular,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          counterText: "",
          errorText: error,
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.contentAccent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: appColors.contentAccent, // Red border for errors
              width: 2.0,
            ),
          ),
        ),
        maxLines: 1,
        readOnly: readonly,
        style: TextStyle(
          color: appColors.contentPrimary,
          fontSize: 16,
          fontFamily: appFonts.NunitoRegular,
          fontWeight: FontWeight.w600,
        ),
      );
    },
  );
}

Widget passwordField(
  TextEditingController controller,
  FocusNode focusNode,
  double width,
  VoidCallback onTap,
  void Function(String) onSubmitted, {
  int maxLength = 320,
  double contentPadding = 12,
  String hint = '',
  dynamic error,
  bool obscure = false,
  void Function(String)? onChange,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onTapOutside: (value) => focusNode.unfocus(),
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        onChanged: onChange,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: Icon(
                obscure
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                size: 22,
                color: appColors.contentPrimary,
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(contentPadding),
          // contentPadding: Platform.isIOS
          //     ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
          //     : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: appColors.contentPlaceholderPrimary,
            fontFamily: appFonts.NunitoRegular,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          counterText: "",
          errorText: error,
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.contentAccent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: appColors.contentAccent, // Red border for errors
              width: 2.0,
            ),
          ),
        ),
        maxLines: 1,
        textAlign: TextAlign.start,
        obscureText: obscure,
        style: TextStyle(
          color: appColors.contentPrimary,
          fontSize: 16,
          fontFamily: appFonts.NunitoRegular,
          fontWeight: FontWeight.w600,
        ),
      );
    },
  );
}

Widget commonChatField(
  TextEditingController controller,
  FocusNode focusNode,
  double width,
  VoidCallback onTap,
  void Function(String) onSubmitted, {
  int maxLength = 320,
  double contentPadding = 16,
  String hint = '',
  void Function(String)? onChange,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return SizedBox(
        width: width,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          maxLength: maxLength,
          onTapOutside: (value) => focusNode.unfocus(),
          onSubmitted: onSubmitted,
          inputFormatters: inputFormatters,
          onChanged: onChange,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onTap,
                child: Transform.rotate(
                  angle: 220 * (3.141592653589793 / 180),
                  child: Icon(
                    Icons.attach_file_sharp,
                    size: 26,
                    color: Colors.black.withOpacity(1),
                  ),
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(contentPadding),
            // contentPadding: Platform.isIOS
            //     ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
            //     : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            isDense: true,
            hintText: hint,
            hintStyle: TextStyle(
              color: appColors.buttonTextStateDisabled,
              fontFamily: appFonts.NunitoRegular,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            counterText: "",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
          maxLines: 1,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: appColors.contentPrimary,
            fontSize: 16,
            fontFamily: appFonts.NunitoRegular,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    },
  );
}

Widget singlePhoneTextField(
  TextEditingController controller,
  String countryCode,
  FocusNode focusNode,
  double width,
  double height, {
  FormFieldValidator<String>? validator,
  int maxLength = 15,
  String hint = '',
  bool enabled = true,
  bool obscure = false,
  String initialValue = "us",
  TextInputType keyboardType = TextInputType.phone,
  void Function(String)? onChange,
  void Function(Country)? onCountryChanged,
  ValueChanged<PhoneNumber>? onCountryCodeChange,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return IntlPhoneField(
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(12),
            // contentPadding: Platform.isIOS
            //     ? const EdgeInsets.symmetric(vertical:10 , horizontal: 15)
            //     : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            errorStyle: TextStyle(
              color: appColors.contentAccent,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              height: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appColors.border),
            ),
            isDense: true,
            hintText: hint,
            hintStyle: TextStyle(
              color: appColors.contentPlaceholderPrimary,
              fontFamily: appFonts.NunitoRegular,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            //counterText: "",
          ),
          style: TextStyle(color: appColors.contentPrimary),
          dropdownTextStyle: TextStyle(color: appColors.contentPrimary),
          showDropdownIcon: false,
          flagsButtonPadding: const EdgeInsets.only(left: 8),
          // cursorColor: Colors.transparent,
          // showCursor: false,
          //initialCountryCode: initialValue=="+1"?'US':"+1",
          //languageCode: "en",
          onChanged: onCountryCodeChange,
          onCountryChanged: onCountryChanged);
    },
  );
}

Widget phoneTextField(
  TextEditingController controller,
  String countryCode,
  FocusNode focusNode,
  double width,
  double height, {
  FormFieldValidator<String>? validator,
  int maxLength = 15,
  String hint = '',
  bool enabled = true,
  bool obscure = false,
  String initialValue = "us",
  TextInputType keyboardType = TextInputType.phone,
  void Function(String)? onChange,
  void Function(Country)? onCountryChanged,
  ValueChanged<PhoneNumber>? onCountryCodeChange,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return SizedBox(
        width: width,
        child: Row(
          children: [
            controller.value.text.isNotEmpty
                ? const SizedBox(
                    height: 2,
                  )
                : const SizedBox(
                    height: 1,
                  ),
            SizedBox(
              width: width * 0.25,
              child: IntlPhoneField(
                  focusNode: focusNode,
                  controller: controller,
                  initialValue: initialValue,
                  //readOnly: true,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(12),
                    errorStyle: const TextStyle(
                      height: -0.01,
                      fontSize: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                          color:
                              appColors.border), // No border on the right side
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                          color: appColors
                              .border), // Border on the left, top, and bottom
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                          color: appColors
                              .border), // Border on the left, top, and bottom
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                          color: appColors
                              .border), // Border on the left, top, and bottom
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                          color: appColors
                              .border), // Border on the left, top, and bottom
                    ),
                    isDense: true,
                    //hintText: hint,
                    hintStyle: TextStyle(
                      color: appColors.contentPlaceholderPrimary,
                      fontFamily: appFonts.NunitoRegular,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    counterText: "",
                    errorText: null,
                  ),
                  style: const TextStyle(
                    color: Colors.transparent,
                    overflow: TextOverflow.ellipsis,
                  ),
                  dropdownTextStyle: TextStyle(color: appColors.contentPrimary),
                  showDropdownIcon: false,
                  flagsButtonPadding: const EdgeInsets.only(left: 8),
                  cursorColor: Colors.transparent,
                  showCursor: false,
                  initialCountryCode: initialValue == "+1" ? 'US' : null,
                  //languageCode: "en",
                  onChanged: onCountryCodeChange,
                  onCountryChanged: onCountryChanged),
            ),
            const VerticalDivider(
              color: Colors.grey,
              width: 0,
            ),
            SizedBox(
              width: width * 0.64,
              child: TextFormField(
                controller: controller,
                focusNode: focusNode,
                validator: validator,
                maxLength: maxLength,
                obscureText: obscure,
                onTapOutside: (value) => focusNode.unfocus(),
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                onChanged: onChange,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(12),
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: appColors.contentPlaceholderPrimary,
                    fontFamily: appFonts.NunitoRegular,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    borderSide: BorderSide(
                        color: appColors.border), // No border on the right side
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    borderSide: BorderSide(
                        color: appColors
                            .border), // Border on the left, top, and bottom
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    borderSide: BorderSide(
                        color: appColors
                            .border), // Border on the left, top, and bottom
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget dropdownButton(
  List<String> items,
  String? selectedValue,
  double width,
  double height,
  Color color,
  void Function(String?) onChanged, {
  String hint = '',
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: appColors.border), // Outer border
    ),
    //padding: const EdgeInsets.all(1.0),
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          //underline: Container(),
          hint: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: selectedValue?.isNotEmpty ?? false
                ? Text(
                    selectedValue ?? "",
                    style: TextStyle(
                        fontSize: 16,
                        color: appColors.contentPrimary,
                        fontFamily: appFonts.NunitoRegular,
                        fontWeight: FontWeight.bold),
                  )
                : Text(hint),
          ),
          style: TextStyle(
              fontSize: 16,
              color: appColors.contentPrimary,
              fontFamily: appFonts.NunitoRegular,
              fontWeight: FontWeight.bold),
          //value: selectedValue,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              alignment: AlignmentDirectional.centerStart,
              value: item,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16),
                    child: Text(
                      item,
                      style: TextStyle(
                          fontSize: 16,
                          color: appColors.contentPrimary,
                          fontFamily: appFonts.NunitoRegular,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  if (item != items.last)
                    Divider(
                      thickness: 1.5,
                      height: 1.5,
                      color: appColors.border,
                    ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            width: width * 0.88,
            offset: const Offset(4, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            padding: EdgeInsets.zero,
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.zero,
          ),

          isExpanded: true,
          iconStyleData: const IconStyleData(
            icon: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 22,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget checkBox(
  bool value,
  double scale,
  double radius,
  double border,
  Color selectedColor,
  Color selectedFillColor,
  Color fillColor,
  Color borderColor,
  ValueChanged<bool?> onChanged,
) {
  return Transform.scale(
    scale: scale,
    child: Checkbox(
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius), // Set border radius
      ),
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(
          color:
              states.contains(WidgetState.selected) ? borderColor : borderColor,
          width: border, // Border width
        ),
      ),
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? selectedFillColor
            : fillColor,
      ),
      checkColor: selectedColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    ),
  );
}

Widget commonOverlayButton(
  double width,
  double height,
  Color backgroundColor,
  Color color,
  VoidCallback? onChanged, {
  String hint = '',
  double radius = 12,
  double paddingVertical = 0,
  double paddingHorizontal = 0,
  double fontSize = 16,
  Color borderColor = Colors.transparent,
}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
          vertical: paddingVertical, horizontal: paddingHorizontal),
      minimumSize: Size(width, height),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
    ).copyWith(
      overlayColor:
          MaterialStateProperty.all(Colors.transparent), // Removes splash
    ),
    child: Text(
      hint,
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: appFonts.NunitoMedium,
          fontWeight: FontWeight.w600,
          color: color),
    ),
  );
}


Widget commonButton(
  double width,
  double height,
  Color backgroundColor,
  Color color,
  VoidCallback? onChanged, {
  String hint = '',
  double radius = 12,
  double paddingVertical = 0,
  double paddingHorizontal = 0,
  double fontSize = 16,
  Color borderColor = Colors.transparent,
}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
          vertical: paddingVertical, horizontal: paddingHorizontal),
      minimumSize: Size(width, height),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
    ),
    child: Text(
      hint,
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: appFonts.NunitoMedium,
          fontWeight: FontWeight.w600,
          color: color),
    ),
  );
}

Widget commonButtonWithLoader(
    double width,
    double height,
    Color backgroundColor,
    Color color,
Rx<bool> isLoading,
    VoidCallback? onChanged, {
      String hint = '',
      double radius = 12,
      double paddingVertical = 0,
      double paddingHorizontal = 0,
      double fontSize = 16,
      Color borderColor = Colors.transparent,
    }) {
  return Obx(()=> ElevatedButton(
    onPressed: isLoading.value ? null : onChanged, // Disable when loading
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
          vertical: paddingVertical, horizontal: paddingHorizontal),
      minimumSize: Size(width, height),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
    ),
    child: isLoading.value
        ? SizedBox(
      width: fontSize,
      height: fontSize,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    )
        : Text(
      hint,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: appFonts.NunitoMedium,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  ));
}

Widget commonButtonWithoutWidth(
  Color backgroundColor,
  Color color,
  VoidCallback? onChanged, {
  Color borderColor = Colors.transparent,
  bool bold = false,
  double fontSize = 16,
  double padding = 4.0,
  String hint = '',
  double radius = 12,
}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, 33),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Text(
        hint,
        style: TextStyle(
            fontSize: fontSize,
            fontFamily: bold ? appFonts.NunitoBold : appFonts.NunitoMedium,
            fontWeight: FontWeight.w600,
            color: color),
      ),
    ),
  );
}

Widget commonButtonShadow(
  double width,
  double height,
  Color borderColor,
  Color backgroundColor,
  Color color,
  VoidCallback? onChanged, {
  String hint = '',
  double radius = 12,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: appColors.contentAccent.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ElevatedButton(
      onPressed: onChanged,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        minimumSize: Size(width, height),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor, width: 1),
        ),
        shadowColor: Colors.transparent,
      ),
      child: Text(
        hint,
        style: TextStyle(
          fontSize: 16,
          fontFamily: appFonts.NunitoMedium,
          fontWeight: FontWeight.w600,
          color: color, // Text color
        ),
      ),
    ),
  );
}

Widget commonButtonIcon(
  double width,
  double height,
  Color backgroundColor,
  Color color,
  VoidCallback? onChanged, {
  String hint = '',
  double radius = 12,
  IconData icon = Icons.arrow_forward_ios,
  bool forward = true,
  Color borderColor = Colors.transparent,
}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      minimumSize: Size(width, height),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        forward
            ? Text(
                hint,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: appFonts.NunitoMedium,
                    fontWeight: FontWeight.w600,
                    color: color),
              )
            : Icon(
                icon,
                color: color,
                size: 18,
              ),
        const SizedBox(
          width: 5,
        ),
        forward
            ? Icon(
                icon,
                color: color,
                size: 18,
              )
            : Text(
                hint,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: appFonts.NunitoMedium,
                    fontWeight: FontWeight.w600,
                    color: color),
              ),
      ],
    ),
  );
}

Widget commonColorTags(
  Color backgroundColor,
  Color color, {
  Color borderColor = Colors.transparent,
  bool bold = false,
  double fontSize = 16,
  double padding = 4.0,
  double vPadding = 0.0,
  String hint = '',
  double radius = 12,
}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: borderColor,
        width: 1,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: vPadding),
      child: Text(
        hint,
        style: TextStyle(
            fontSize: fontSize,
            fontFamily: bold ? appFonts.NunitoBold : appFonts.NunitoMedium,
            fontWeight: FontWeight.w600,
            color: color),
      ),
    ),
  );
}

Widget commonButtonFilters(
  Color backgroundColor,
  Color color,
  VoidCallback? onChanged, {
  String hint = '',
  double radius = 12,
  double fontSize = 16,
  IconData icon = Icons.close,
  Color borderColor = Colors.transparent,
}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: borderColor,
        width: 1,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hint,
            style: TextStyle(
                fontSize: fontSize,
                fontFamily: appFonts.NunitoMedium,
                fontWeight: FontWeight.w600,
                color: color),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onChanged,
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget commonOnBoardingButton(
  double value,
  VoidCallback? onChanged, {
  double width = 62,
  double height = 62,
  IconData icon = Icons.arrow_forward_ios,
}) {
  return GestureDetector(
    onTap: onChanged,
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: 4.0,
            valueColor: const AlwaysStoppedAnimation<Color>(
              Colors.orange,
            ),
            backgroundColor: appColors.contentAccent.withOpacity(0.2),
          ),
        ),
        Container(
          width: (width - 12),
          height: (height - 12),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.orange,
                Colors.red,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    ),
  );
}

Widget commonButtonBlack(
  Color backgroundColor,
  Color color,
  VoidCallback? onChanged, {
  bool isIcon = true,
  String hint = '',
  double radius = 12,
  IconData icon = Icons.close,
  Color borderColor = Colors.transparent,
}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      minimumSize: const Size(0, 35),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
    ),
    child: Text(
      hint,
      style: TextStyle(
          fontSize: 16,
          fontFamily: appFonts.NunitoMedium,
          fontWeight: FontWeight.w600,
          color: color),
    ),
  );
}

Widget radioButtonObjective(
  String value,
  Rx<String> selectedValue,
  Color selectedColor,
  Color textColor,
  String hint,
  VoidCallback? onTap, {
  double borderRadius = 12,
}) {
  return Obx(
    () => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
              color: selectedValue.value == value
                  ? appColors.contentAccent
                  : appColors.buttonStateDisabled,
              width: 2),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              selectedValue.value == value
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: selectedValue.value == value ? selectedColor : textColor,
              size: 25,
            ),
            const SizedBox(
              width: 6,
            ),
            Flexible(
              child: Text(
                textAlign: TextAlign.start,
                hint,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.appFonts.NunitoBold,
                    color: appColors.contentPrimary),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget checkButtonObjective(
    int index,
    RxList<bool> selectedList,
    Color selectedColor,
    Color textColor,
    String hint,
    VoidCallback? onTap, {
      double borderRadius = 12, // outer container border radius
    }) {
  return Obx(
        () => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: selectedList[index]
                ? selectedColor
                : appColors.buttonStateDisabled,
            width: 2,
          ),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedList[index] ? selectedColor : textColor,
                  width: 2,
                ),
                color: selectedList[index] ? selectedColor : Colors.transparent,
              ),
              child: selectedList[index]
                  ? const Icon(
                Icons.check,
                weight: 200,
                size: 16,
                color: Colors.white,
              )
                  : null,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                hint,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: AppFonts.appFonts.NunitoBold,
                  color: appColors.contentPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


Widget radioButtonAnswersObjective(
  bool answerValue,
  bool correctValue,
  String hint, {
  double borderRadius = 12,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
          color: answerValue && correctValue
              ? appColors.accentGreen
              : correctValue
                  ? appColors.accentGreen
                  : answerValue
                      ? appColors.backgroundNegative
                      : appColors.buttonStateDisabled,
          width: 2),
      color: answerValue && correctValue
          ? appColors.correctBackgroundColor
          : answerValue
              ? appColors.wrongBackgroundColor
              : Colors.white,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          answerValue && correctValue
              ? Icons.check_circle
              : correctValue
                  ? Icons.check_circle
                  : answerValue
                      ? Icons.cancel
                      : Icons.circle_outlined,
          color: answerValue && correctValue
              ? appColors.accentGreen
              : correctValue
                  ? appColors.accentGreen
                  : answerValue
                      ? appColors.backgroundNegative
                      : appColors.contentPrimary,
          size: 25,
        ),
        const SizedBox(
          width: 6,
        ),
        Flexible(
          child: Text(
            textAlign: TextAlign.start,
            hint,
            style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.appFonts.NunitoBold,
                color: appColors.contentPrimary),
          ),
        ),
      ],
    ),
  );
}

Widget emailFieldCheck(
  TextEditingController controller,
  FocusNode focusNode,
  Color color,
  double width,
  double height, {
  FormFieldValidator<String>? validator,
  int maxLength = 320,
  String hint = '',
  bool enabled = true,
  bool obscure = false,
  TextInputType keyboardType = TextInputType.text,
  void Function(String)? onChange,
}) {
  // Variable to hold the error message
  String? errorMessage;

  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;

      focusNode.addListener(() {
        setState(() {});
      });

      // Perform validation and get the error message
      if (validator != null) {
        errorMessage = validator(controller.text);
      }

      Color borderColor = errorMessage != null
          ? Colors.red // Change border color to red when there's an error
          : (isHovered || focusNode.hasFocus)
              ? Color(appColors.buttonNew)
              : Color(appColors.colorPrimaryNew);

      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: borderColor,
                width: 1.0), // Border color based on error state
          ),
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  enabled: enabled,
                  maxLength: maxLength,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: onChange,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    contentPadding: Platform.isIOS
                        ? const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 15)
                        : const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                    isDense: true,
                    hintText: hint,
                    counterText: "",
                    border: InputBorder.none, // No border here
                    hintStyle: TextStyle(
                      color: Color(appColors.searchHint),
                      fontSize: 16,
                    ),
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  obscureText: obscure,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: appFonts.robotsRegular,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              // Display the error message directly below the TextFormField
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(
                      top:
                          4.0), // Space between the text field and error message
                  child: Text(
                    errorMessage ?? "",
                    style: TextStyle(
                      color: Colors.red[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

Widget otpField(
  TextEditingController controller,
  FocusNode focusNode,
  Color color,
  double width,
  double height,
  void Function(String) onSubmitted, {
  int maxLegth = 320,
  String hint = '',
  bool enabled = true,
  bool obscure = false,
  TextInputType keyboardType = TextInputType.number,
  void Function(String)? onChange,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;
      focusNode.addListener(() {
        setState(() {});
      });
      Color borderColor = isHovered || focusNode.hasFocus
          ? Color(appColors.buttonNew)
          : Color(appColors.colorPrimaryNew);
      double animatedWidth = focusNode.hasFocus ? width * 1.05 : width;
      double animatedHeight = focusNode.hasFocus ? height * 1 : height;
      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: animatedWidth,
          height: animatedHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1.0),
          ),
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              maxLength: 4,
              onSubmitted: onSubmitted,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Only digits allowed
                LengthLimitingTextInputFormatter(4), // Limit input to 4 digits
              ],
              onChanged: onChange,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                contentPadding: Platform.isIOS
                    ? const EdgeInsets.symmetric(vertical: 13, horizontal: 15)
                    : const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(
                  color: Color(appColors.searchHint),
                  fontSize: 16,
                ),
                counterText: "",
                border: InputBorder.none,
              ),
              maxLines: 1,
              textAlign: TextAlign.start,
              obscureText: obscure,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: appFonts.robotsRegular,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      );
    },
  );
}

Container commonContainerOutlined(double width, double height, child, color) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white, // Set a solid background color if needed
      borderRadius: BorderRadius.circular(25), // Circular border
      border: Border.all(
          color: Color(appColors.colorPrimaryNew), width: 1.0), // Black border
    ),
    padding:
        const EdgeInsets.all(0.0), // Padding to set space for the black border
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color, // Inner background color
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    ),
  );
}

Text titleText(String text,
    {double fontSize = 20.0,
    fontFamily = 'RobotsRegular',
    var color = Colors.black,
    var fontWeight = FontWeight.w600}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color,
        overflow: TextOverflow.ellipsis,
        fontWeight: fontWeight),
  );
}

Text descriptionText(
  String text, {
  double fontSize = 11.0,
  double height = 0,
  fontFamily = 'RobotsRegular',
  var color = Colors.black,
  textAlign = TextAlign.start,
  var fontWeight = FontWeight.bold,
  underLine = false,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      height: height,
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight,
      decoration: underLine ? TextDecoration.underline : TextDecoration.none,
    ),
  );
}

EdgeInsets edgeInsetsAll({all = 0.0}) {
  return EdgeInsets.all(all.toDouble());
}

Padding paddingOnly({left = 0.0, right = 0.0, bottom = 0.0, top = 0.0}) {
  return Padding(
    padding: EdgeInsets.only(
        left: left.toDouble(),
        right: right.toDouble(),
        bottom: bottom.toDouble(),
        top: top.toDouble()),
  );
}

Padding paddingAll({all = 0.0}) {
  return Padding(padding: EdgeInsets.all(all.toDouble()));
}

EdgeInsets edgeInsetsOnly({left = 0.0, right = 0.0, top = 0.0, bottom = 0.0}) {
  return EdgeInsets.only(
      left: left.toDouble(),
      right: right.toDouble(),
      top: top.toDouble(),
      bottom: bottom.toDouble());
}

SizedBox phoneNumberFieldWithoutGradient(controller, focusNode, w) {
  return SizedBox(
    width: w,
    child: IntlPhoneField(
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        counterText: "",
        // Set label text color to white
        hintText: appStrings.hintPhone,
        hintStyle: TextStyle(
            color: Color(appColors.searchHint)), // Set hint text color to white
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Color(appColors.colorPrimaryNew),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Color(appColors.colorPrimaryNew),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
      ),
      style: const TextStyle(color: Colors.black),
      dropdownTextStyle: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      dropdownIcon: Icon(
        Icons.arrow_drop_down,
        color: Color(appColors.colorPrimaryNew),
        size: 24,
      ),
      languageCode: "en",
      onChanged: (phone) {
        if (kDebugMode) {
          print(phone.completeNumber);
        }

        if (phone.number.isNotEmpty) {}
      },
      onCountryChanged: (country) {
        if (kDebugMode) {
          print('Country changed to: ${country.dialCode}');
        }
      },
    ),
  );
}
