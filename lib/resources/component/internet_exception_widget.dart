import 'package:flutter/material.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';
import 'package:vroar/utils/sized_box_extension.dart';


import '../../main.dart';
import '../colors.dart';
import '../strings.dart';

class InternetExceptionWidget extends ParentWidget {
  final VoidCallback onPress;
  const InternetExceptionWidget({super.key,required this.onPress});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Container(
      color: appColors.noInternetBack,
      height: h,
      width: w,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(appStrings.noInternetConnection,textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontFamily: appFonts.NunitoBold),),
            Image.asset(appImages.noInternet,width: w*0.7,),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Text(appStrings.weUnableCheckData,textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontFamily: appFonts.NunitoBold),),
              ),
            ),
            35.kH,
            GestureDetector(
              onTap: onPress,
              child: Container(
                height: 44,
                width: 160,
                decoration: BoxDecoration(
                    color: appColors.contentAccent,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Center(child: Text(appStrings.retry,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
