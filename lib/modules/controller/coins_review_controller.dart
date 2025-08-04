import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vroar/models/coin_history_model.dart';
import 'package:vroar/models/get_total_coin_model.dart';
import 'package:vroar/modules/repository/coin_repository.dart';
import 'package:vroar/modules/repository/event_repository.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../models/get_event_list_model.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import 'common_screen_controller.dart';

class CoinsReviewController extends GetxController {
  var isButton = true.obs;
  var searchController = TextEditingController().obs;
  var searchFocusNode = FocusNode().obs;
  CommonScreenController commonScreenController = Get.put(CommonScreenController());

  final api = CoinRepository();
  final eventApi = EventRepository();

  String getDate(var unixTimeStamp) {
    int startTime = int.parse(unixTimeStamp);

    if (unixTimeStamp.length == 10) {
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

    return "$formattedDate, ";
  }

  final List<Map<String, dynamic>> dataEvent = [
    {'title': 'Webinar', 'message': 'Introduction to Digital Citizenship', 'coins': 150, "date": "1 July, 2024"},
    {'title': 'On-Field Workshop', 'message': 'Exploring Biodiversity in Our Local Ecosystem', 'coins': 250, "date": "1 July, 2024"},
    {'title': 'Mentor Session', 'message': '', 'coins': 150, "date": "1 July, 2024"},
    {'title': 'Webinar', 'message': 'Introduction to Marketing Citizenship', 'coins': 150, "date": "1 July, 2024"},
    {'title': 'Mentor Session', 'message': '', 'coins': 150, "date": "1 July, 2024"},
    {'title': 'Webinar', 'message': 'Introduction to Digital Citizenship', 'coins': 150, "date": "1 July, 2024"},
    {'title': 'On-Field Workshop', 'message': 'Exploring Biodiversity in Our Local Ecosystem', 'coins': 250, "date": "1 July, 2024"},
    {'title': 'Mentor Session', 'message': '', 'coins': 150, "date": "1 July, 2024"},
    {'title': 'Webinar', 'message': 'Introduction to Marketing Citizenship', 'coins': 150, "date": "1 July, 2024"},
    {'title': 'Mentor Session', 'message': '', 'coins': 150, "date": "1 July, 2024"},
    {'title': 'Webinar', 'message': 'Introduction to Digital Citizenship', 'coins': 150, "date": "1 July, 2024"},
    {'title': 'On-Field Workshop', 'message': 'Exploring Biodiversity in Our Local Ecosystem', 'coins': 250, "date": "1 July, 2024"},
    {'title': 'Mentor Session', 'message': '', 'coins': 150, "date": "1 July, 2024"},
    {'title': 'Webinar', 'message': 'Introduction to Marketing Citizenship', 'coins': 150, "date": "1 July, 2024"},
  ];

  final CommonScreenController mainController = Get.put(CommonScreenController());

  final rxRequestStatus = Status.COMPLETED.obs;
  final totalCoinData = GetTotalCoinModel().obs;
  final coinHistoryData = CoinHistoryModel().obs;
  final eventListData = GetEventListModel().obs;
  void setError(String value) => error.value = value;
  var error = RxnString();
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setCoins(GetTotalCoinModel value) => totalCoinData.value = value;
  void setCoinsHistory(CoinHistoryModel value) => coinHistoryData.value = value;
  void setEventListData(GetEventListModel value) => eventListData.value = value;

  Future<void> getTotalCoinApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      api.getTotalCoinApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setCoins(value);
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

  Future<void> getEventListApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      eventApi.getEventListApi(1, 200).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setEventListData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        getFilter(value, "PAID", "UPCOMING");
        Utils.printLog("Response===> ${eventListData.toString()}");
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

  void getFilter(GetEventListModel value, String eventType, String status) {
    final filteredPaidEvent = Rxn<GetEventListModel>();
    final filteredDocs = value.data?.docs?.where((event) => event.eventType != null && event.eventType == eventType && event.status == status).toList();

    filteredPaidEvent.value = GetEventListModel(
      message: value.message,
      statusCode: value.statusCode,
      data: EventData(
        docs: filteredDocs,
        hasNextPage: value.data?.hasNextPage,
        hasPrevPage: value.data?.hasPrevPage,
        limit: value.data?.limit,
        page: value.data?.page,
        totalDocs: value.data?.totalDocs,
        totalPages: value.data?.totalPages,
      ),
    );
    setEventListData(filteredPaidEvent.value ?? GetEventListModel());
  }

  void getFilterCoinEventHistory(CoinHistoryModel value) {
    final filteredEventHistory = Rxn<CoinHistoryModel>();
    final filteredDocs = value.data?.docs?.where((event) => event.actionType != null && event.actionType == "REDEEM").toList();

    filteredEventHistory.value = CoinHistoryModel(
      message: value.message,
      statusCode: value.statusCode,
      data: DataCoinHistory(
        docs: filteredDocs,
        hasNextPage: value.data?.hasNextPage,
        hasPrevPage: value.data?.hasPrevPage,
        limit: value.data?.limit,
        page: value.data?.page,
        totalDocs: value.data?.totalDocs,
        totalPages: value.data?.totalPages,
      ),
    );
    setCoinsHistory(filteredEventHistory.value ?? CoinHistoryModel());
  }

  Future<void> getCoinHistoryApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      api.getCoinHistoryApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setCoinsHistory(value);
        getFilterCoinEventHistory(value);
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
}
