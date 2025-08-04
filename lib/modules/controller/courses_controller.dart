import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/models/get_all_roadmap_model.dart';
import 'package:vroar/modules/repository/roadmap_repository.dart';

import '../../common/Constants.dart';
import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import '../repository/profile_repository.dart';
import 'common_screen_controller.dart';

class CoursesController extends GetxController {
  final api = RoadmapRepository();
  var activeNodes = List.generate(0, (index) => index==0?true.obs: false.obs);

  var haveData=false.obs;
  var reloadData = true.obs;

  final CommonScreenController mainController = Get.put(CommonScreenController());

  final rxRequestStatus = Status.COMPLETED.obs;
  final getAllRoadMapData = GetAllRoadMapModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setGetAllRoadMapData(GetAllRoadMapModel value) => getAllRoadMapData.value = value;

  Future<void> getCoursesApi(id,bool reload) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      if(reload){
        setRxRequestStatus(Status.LOADING);
      }

      Map<String, dynamic> data = {
        "userId":id
      };

      api.getAllRoadmapApi(data).then((value) {
        if(reload){
          setRxRequestStatus(Status.COMPLETED);
        }
        setGetAllRoadMapData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        if(reload){
            activeNodes = List.generate(value.data?.docs?.length??2, (index) => index==0?true.obs: false.obs);
        }
        haveData.value=true;
        reloadData.value=false;
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            CommonMethods.showToast(errorResponse['message']);
          } else {
            CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
        Utils.printLog("stackTrace===> ${stackTrace.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> coursesRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    getCoursesApi(mainController.getProfileData.value.data?.id??0,true);
    print("items.length");
  }

}
