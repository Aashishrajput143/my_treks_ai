

import 'package:vroar/models/get_mentor_details_model.dart';
import 'package:vroar/models/get_mentor_list_model.dart';
import 'package:vroar/models/session_book_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';

class MentorRepository {
  final _apiServices = NetworkApiServices();

  Future<GetMentorListModel> getMentorList() async {
    dynamic response =
    await _apiServices.getApi(AppUrl.mentorList);
    return GetMentorListModel.fromJson(response);
  }

  Future<GetMentorDetailsModel> getMentorDetails(var id) async {
    dynamic response =
    await _apiServices.getApi("${AppUrl.mentorDetails}$id");
    return GetMentorDetailsModel.fromJson(response);
  }

  Future<BookSessionModel> bookSessionApi(var data) async {
    dynamic response =
    await _apiServices.postEncodeApi(data, AppUrl.bookSession);
    return BookSessionModel.fromJson(response);
  }
}
