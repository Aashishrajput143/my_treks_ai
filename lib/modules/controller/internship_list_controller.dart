import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/common/app_constants_list.dart';
import 'package:vroar/models/get_internship_list_model.dart';
import 'package:vroar/modules/repository/internship_repository.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import 'common_screen_controller.dart';

class InternshipListController extends GetxController {
  final api = InternshipRepository();
  var searchController = TextEditingController().obs;
  var searchFocusNode = FocusNode().obs;
  var checkBoxList = List.generate(6, (index) => false.obs).obs;
  List<String> filters = AppConstantsList.filters;

  RxList<String> selectedFilters = <String>[].obs;
  RxList<String> selectedFiltersButton = <String>[].obs;
  var applyFilters = false.obs;

  var filteredInternship = <Docs>[].obs; // filtered list based on search

  void searchInternship(String query) {
    final q = query.toLowerCase().trim();

    if (q.isEmpty) {
      filteredInternship.assignAll(getInternshipData.value.data?.docs ?? []);
    } else {
      filteredInternship.assignAll(
        getInternshipData.value.data?.docs?.where((internship) {
              Utils.printLog(internship.skills);
              final searchableText = [internship.companyName ?? '', internship.title ?? '', ...(internship.skills != null && internship.skills is List<String> ? internship.skills as List<String> : [])].join(' ').toLowerCase();

              return q.split(' ').every((word) => searchableText.contains(word));
            }) ??
            [],
      );
    }
  }

  void toggleFilter(String filter) {
    Utils.printLog(filter);
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    Utils.printLog(selectedFilters);
  }

  final CommonScreenController mainController = Get.put(CommonScreenController());

  final rxRequestStatus = Status.COMPLETED.obs;
  final getInternshipData = GetInternshipListModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setInternshipListData(GetInternshipListModel value) => getInternshipData.value = value;

  Future<void> getInternshipListApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "status": "Open",
        // "search": "D",
        "page": 1,
        "pageSize": 200
      };
      api.getInternshipListApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setInternshipListData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        Utils.printLog("redirect");
        searchInternship("");
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          Utils.printLog("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            CommonMethods.showToast(errorResponse['message']);
          } else {
            CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
