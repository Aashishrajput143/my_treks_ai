

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/strings.dart';

import '../../common/common_widgets.dart';
import '../../resources/colors.dart';

class NotificationScreen extends ParentWidget{
  const NotificationScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      appBar: AppBar(
        title: titleText("Notification"),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(

        height: h*0.9,
        width: w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              paddingOnly(top: 10),




              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  physics: const NeverScrollableScrollPhysics(),

                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        // Get.toNamed(RoutesClass.gotoInternshipDetailScreen(),arguments: controller.internshipModel.value.data?.docs?[index].sId);
                      },
                      child: Container(
                        margin: edgeInsetsOnly(left: 20,right: 20,top: 10,bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(appColors
                                    .searchHint),
                                blurRadius: 1.0,
                                // soften the shadow

                              )
                            ],
                            borderRadius: const BorderRadius.all(Radius.circular(14.0))
                        ),
                        height:Platform.isIOS? h * 0.15:h * 0.15,
                        child: Container(
                          margin:  edgeInsetsOnly(left:  10,top: 20,right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Row(
                               children: [
                                 SizedBox(

                                   width: 70, // Exact width of the profile icon
                                   height: 70, // Exact height of the profile icon
                                   child: ClipRRect(

                                     borderRadius: BorderRadius.circular(100), // Round corners
                                     child: Container(
                                       color: Color(appColors.colorPrimaryNew), // Background color of the icon
                                       child: const Center(
                                         child: Icon(
                                           Icons.person, // Profile icon
                                           color: Colors.white, // Icon color
                                           size: 24, // Icon size
                                         ),
                                       ),
                                     ),
                                   ),
                                 ),
                                 paddingOnly(left: 10),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     titleText("Ananya Srivastava"),
                                     SizedBox(
                                       width: w*0.6,
                                         child: descriptionText(appStrings.appliedDesc,color: Color(appColors.searchHint),))
                                   ],
                                 )
                               ],
                             )

                            ],
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

}
