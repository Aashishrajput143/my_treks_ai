import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vroar/models/get_event_by_id_model.dart';
import 'package:vroar/modules/repository/event_repository.dart';
import 'package:vroar/modules/screen/session_details.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../models/redeem_rewards_model.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';

class SessionDetailsController extends GetxController with WidgetsBindingObserver {
  final api = EventRepository();
  final eventId = "0".obs;
  final currentIndex = 0.obs;

  var isPaid = true.obs;
  var shouldShowDialogOnResume = false.obs;
  var tag = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    currentIndex.value = arguments['index'];
    eventId.value = arguments['id'];
    String eventType = arguments['eventType'];
    isPaid.value = eventType == "PAID" ? true : false;
    tag.value = arguments['Tag'];
    print("internshipId${eventId.value}");
    getEventApi();
    WidgetsBinding.instance.addObserver(this);
  }

  String getDateTime(var startUnixTimeStamp, var endUnixTimeStamp) {
    int startTime = int.parse(startUnixTimeStamp);
    // int endTime = int.parse(endUnixTimeStamp);

    if (startUnixTimeStamp.length == 10) {
      startTime *= 1000;
    }
    // if (endUnixTimeStamp.length == 10) {
    //   endTime *= 1000;
    // }

    DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(startTime);
    // DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(endTime);

    //print(startDateTime);

    String dayWithSuffix(int day) {
      if (day >= 11 && day <= 13) return '${day}th';
      switch (day % 10) {
        case 1:
          return '${day}st';
        case 2:
          return '${day}nd';
        case 3:
          return '${day}rd';
        default:
          return '${day}th';
      }
    }

    String formattedDate = "${dayWithSuffix(startDateTime.day)} ${DateFormat('MMM, yyyy').format(startDateTime)}";
    // String formattedTime = "${DateFormat('h:mm').format(startDateTime)}-${DateFormat('h:mm a').format(endDateTime)}";

    return "$formattedDate | ";
  }

  String getTime(var startUnixTimeStamp, var endUnixTimeStamp) {
    int startTime = int.parse(startUnixTimeStamp);
    int endTime = int.parse(endUnixTimeStamp);

    if (startUnixTimeStamp.length == 10) {
      startTime *= 1000;
    }
    if (endUnixTimeStamp.length == 10) {
      endTime *= 1000;
    }

    DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(startTime);
    DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(endTime);

    String formattedTime = "${DateFormat('h:mm').format(startDateTime)} - ${DateFormat('h:mm a').format(endDateTime)}";

    return formattedTime;
  }

  String getDate(var startUnixTimeStamp) {
    int startTime = int.parse(startUnixTimeStamp);

    if (startUnixTimeStamp.length == 10) {
      startTime *= 1000;
    }

    DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(startTime);

    String dayWithSuffix(int day) {
      if (day >= 11 && day <= 13) return '${day}th';
      switch (day % 10) {
        case 1:
          return '${day}st';
        case 2:
          return '${day}nd';
        case 3:
          return '${day}rd';
        default:
          return '${day}th';
      }
    }

    String formattedDate = "${DateFormat('MMMM').format(startDateTime)} ${dayWithSuffix(startDateTime.day)}, ${DateFormat('yyyy').format(startDateTime)}";

    return formattedDate;
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final eventData = GetEventByIdModel().obs;
  final redeemRewardsData = RedeemRewardsModel().obs;
  void setError(String value) => error.value = value;
  var error = RxnString();
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setEventData(GetEventByIdModel value) => eventData.value = value;
  void setRedeemRewards(RedeemRewardsModel value) => redeemRewardsData.value = value;

  Future<void> getEventApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      api.getEventByIdApi(eventId.value).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setEventData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
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

  Future<void> redeemRewardsApi() async {
    const sessionScreen = SessionDetailsScreen();
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      api.redeemRewardsApi(eventData.value.data?.id).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setRedeemRewards(value);
        //CommonMethods.showToastSuccess("${value.message}");
        sessionScreen.paidSuccessDialog();
        Utils.printLog("Response===> ${value.toString()}");
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

  onSubmitFree() async {
    rxRequestStatus.value = Status.LOADING;
    await Future.delayed(const Duration(seconds: 2));
    rxRequestStatus.value = Status.COMPLETED;
    var url = eventData.value.data?.zoomLink ?? "";
    if (await canLaunchUrl(Uri.parse(url))) {
      shouldShowDialogOnResume.value = true;
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not launch the session link.");
    }
  }

  onSubmitPaid() async {
    const sessionScreen = SessionDetailsScreen();
    sessionScreen.paidDialog(eventData.value.data?.coins ?? 0);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    const roadmapScreen = SessionDetailsScreen();
    if (state == AppLifecycleState.resumed && shouldShowDialogOnResume.value) {
      shouldShowDialogOnResume.value = false;
      roadmapScreen.successDialog();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
