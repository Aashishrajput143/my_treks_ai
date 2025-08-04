import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vroar/models/get_event_list_model.dart';
import 'package:vroar/models/roadmap_completion_model.dart';
import 'package:vroar/modules/repository/event_repository.dart';
import 'package:vroar/modules/repository/roadmap_repository.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import 'common_screen_controller.dart';

class HomeController extends GetxController {
  final api = EventRepository();
  final roadmapApi = RoadmapRepository();
  var currentIndex = 0.obs;
  var greetings = "".obs;

  final CommonScreenController mainController = Get.put(CommonScreenController());

  void setGreeting() {
    String time = DateTime.now().toString();
    time = time.split(" ")[1].toString();
    time = time.split(".")[0].toString();
    DateTime timeNow = DateTime.parse("2000-01-01 $time");
    DateTime morningStart = DateTime.parse("2000-01-01 05:00:00");
    DateTime morningEnd = DateTime.parse("2000-01-01 11:59:59");
    DateTime afternoonStart = DateTime.parse("2000-01-01 12:00:00");
    DateTime afternoonEnd = DateTime.parse("2000-01-01 16:59:59");
    DateTime eveningStart = DateTime.parse("2000-01-01 17:00:00");
    DateTime eveningEnd = DateTime.parse("2000-01-01 20:59:59");
    if (timeNow.isAfter(morningStart) && timeNow.isBefore(morningEnd)) {
      greetings.value = "Good Morning";
    } else if (timeNow.isAfter(afternoonStart) && timeNow.isBefore(afternoonEnd)) {
      greetings.value = "Good Afternoon";
    } else if (timeNow.isAfter(eveningStart) && timeNow.isBefore(eveningEnd)) {
      greetings.value = "Good Evening";
    } else {
      greetings.value = "Good Night";
    }
  }

  String getDateTime(var startUnixTimeStamp, var endUnixTimeStamp) {
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
    setGreeting();

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
    String formattedTime = "${DateFormat('h:mm').format(startDateTime)}-${DateFormat('h:mm a').format(endDateTime)}";

    return "$formattedDate | $formattedTime";
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final eventListData = GetEventListModel().obs;
  final roadmapCompletionData = RoadMapCompletionModel().obs;
  void setError(String value) => error.value = value;
  var error = RxnString();
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setEventListData(GetEventListModel value) => eventListData.value = value;
  void setRoadMapCompletionData(RoadMapCompletionModel value) => roadmapCompletionData.value = value;

  Future<void> getEventListApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      api.getEventListApi(1, 200).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setEventListData(value);
        getFilter(value, "FREE", 5, 'UPCOMING');
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
      setRxRequestStatus(Status.NOINTERNET);
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> getRoadmapCompletionApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      roadmapApi.roadmapCompletionApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setRoadMapCompletionData(value);
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
      setRxRequestStatus(Status.NOINTERNET);
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  void getFilter(GetEventListModel value, String eventType, int? count, String status) {
    final filteredPaidEvent = Rxn<GetEventListModel>();
    final filteredDocs = value.data?.docs?.where((event) => event.eventType != null && event.eventType == eventType && event.status == status).take(count ?? 5).toList();

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
}
