import 'package:flutter/material.dart';

import '../../main.dart';
import '../colors.dart';
import '../strings.dart';

class GeneralExceptionWidget extends ParentWidget {
  final VoidCallback onPress;
  const GeneralExceptionWidget({super.key,required this.onPress});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return SizedBox(
      height: h,
      width: w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.announcement_outlined,color: Colors.black, size: 50,),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Text(appStrings.weUnable,textAlign: TextAlign.center,),
            ),
          ),
          SizedBox(height: h * .15,),
          GestureDetector(
            onTap: onPress,
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                  color: Color(appColors.colorPrimary),
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Center(child: Text(appStrings.retry,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),)),
            ),
          )
        ],
      ),
    );
  }
}
