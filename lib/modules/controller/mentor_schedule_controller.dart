import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/common/app_constants_list.dart';
import 'package:vroar/models/get_mentor_list_model.dart';
import 'package:vroar/modules/controller/mentor_details_controller.dart';
import 'package:vroar/modules/repository/mentor_repository.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import 'common_screen_controller.dart';

class MentorScheduleController extends GetxController {
  final _api = MentorRepository();

  var searchController = TextEditingController().obs;
  var searchFocusNode = FocusNode().obs;
  var checkBoxList = List.generate(6, (index) => false.obs).obs;
  List<String> filters = AppConstantsList.filters;

  RxList<String> selectedFilters = <String>[].obs;
  RxList<String> selectedFiltersButton = <String>[].obs;
  var applyFilters = false.obs;

  var filteredMentors = <Docs>[].obs; // filtered list based on search

  void searchMentors(String query) {
    final q = query.toLowerCase().trim();

    if (q.isEmpty) {
      filteredMentors.assignAll(mentorListData.value.data?.docs??[]);
    } else {
      filteredMentors.assignAll(
        mentorListData.value.data?.docs?.where((mentor) {
          final searchableText = [
            mentor.firstName,
            mentor.lastName,
            mentor.designation,
            mentor.currentCompany,
            mentor.totalExperience.toString(),
            ...?mentor.skills,
          ].join(' ').toLowerCase();

          return q.split(' ').every((word) => searchableText.contains(word));
        })??[],
      );
    }
  }




  void toggleFilter(String filter) {
    print(filter);
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    print(selectedFilters);
  }


  final CommonScreenController mainController = Get.put(CommonScreenController());

  final rxRequestStatus = Status.COMPLETED.obs;
  final mentorListData = GetMentorListModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setMentorListData(GetMentorListModel value) =>
      mentorListData.value = value;

  Future<void> getMentorListApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      _api.getMentorList().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setMentorListData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        searchMentors("");
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
