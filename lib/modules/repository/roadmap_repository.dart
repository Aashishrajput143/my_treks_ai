import 'package:vroar/models/answer_submission_model.dart';
import 'package:vroar/models/get-assessment_model.dart';
import 'package:vroar/models/get_all_roadmap_model.dart';
import 'package:vroar/models/get_quiz_model.dart';
import 'package:vroar/models/oboarding_roadmap_models.dart';
import 'package:vroar/models/quiz_result_model.dart';
import 'package:vroar/models/roadmap_completion_model.dart';
import 'package:vroar/models/submit_quiz_model.dart';
import 'package:vroar/models/verify_subscription_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../../models/get_user_roadmap_journey_model.dart';
import '../../models/roadmap_model.dart';

class RoadmapRepository {
  final _apiServices = NetworkApiServices();

  Future<OnBoardingRoadmapJourneyModel> getOnBoardingRoadmapApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.getOnBoardingJourney);
    return OnBoardingRoadmapJourneyModel.fromJson(response);
  }

  Future<OnBoardingRoadmapJourneyUpdateModel> onBoardingRoadmapLevelUpdate(var data) async {
    dynamic response = await _apiServices.putEncodeApi(data, AppUrl.updateOnBoardingJourney);
    return OnBoardingRoadmapJourneyUpdateModel.fromJson(response);
  }

  Future<GetAssessmentModel> onBoardingAssessmentApi(var id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getOnBoardingAssessment}$id");
    return GetAssessmentModel.fromJson(response);
  }

  Future<AnswerSubmissionModel> onBoardingAnswerSubmissionApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.onBoardingAnswerSubmission);
    return AnswerSubmissionModel.fromJson(response);
  }

  Future<GetQuizModel> getQuizApi(var id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getQuiz}$id");
    return GetQuizModel.fromJson(response);
  }

  Future<SubmitQuizModel> submitQuizApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.submitQuiz);
    return SubmitQuizModel.fromJson(response);
  }

  Future<GetUserRoadmapJourneyModel> getRoadmapJourneysListApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.getRoadmapJourneys);
    return GetUserRoadmapJourneyModel.fromJson(response);
  }

  Future<QuizResultModel> getRoadmapQuizResultApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.getQuizResult);
    return QuizResultModel.fromJson(response);
  }

  Future<RoadmapJourneyModel> getRoadmapByIdApi(var id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getRoadMapById}$id");
    return RoadmapJourneyModel.fromJson(response);
  }

  Future<RoadmapJourneyUpdateResponseModel> roadmapLevelUpdate(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.updateRoadmapJourney);
    return RoadmapJourneyUpdateResponseModel.fromJson(response);
  }

  Future<GetAllRoadMapModel> getAllRoadmapApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.getAllRoadMap);
    return GetAllRoadMapModel.fromJson(response);
  }

  Future<RoadMapCompletionModel> roadmapCompletionApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.roadmapCompletion);
    return RoadMapCompletionModel.fromJson(response);
  }

  Future<VerifySubscriptionModel> verifySubscriptionApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.verifySubscription);
    return VerifySubscriptionModel.fromJson(response);
  }
}
