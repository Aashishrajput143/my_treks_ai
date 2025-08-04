import 'app_base_url.dart';

class AppUrl {
  //Staging
  static const String baseUrl = AppBaseUrl.baseUrlMyTreksProduction;

  // static const String baseUrl = AppBaseUrl.baseUrlMyTreksDev;
  // static const String baseUrl = AppBaseUrl.baseUrlMyTreksUAT;

  static String login = '$baseUrl/api/user/login';
  static String register = '$baseUrl/api/user/register';
  static String refreshToken = '$baseUrl/api/user/renewAccessToken';
  static String verify = '$baseUrl/api/user/verify';
  static String appleLogin = '$baseUrl/api/socialLogin/apple/mobile';
  static String googleLogin = '$baseUrl/api/socialLogin/google/mobile';
  static String updateProfile = '$baseUrl/user/api/profile/updateProfile';
  static String uploadMedia = '$baseUrl/user/api/media/upload';
  static String getProfile = '$baseUrl/user/api/user/getUserById';
  static String getLogout = '$baseUrl/api/logout/currentSession';
  static String deleteUser = '$baseUrl/user/api/user/delete';
  static String changePassword = '$baseUrl/api/user/changePassword';
  static String forgetEmail = '$baseUrl/api/forgotPassword';
  static String forgetPassword = '$baseUrl/api/forgotPassword/verify';
  static String userInvite = '$baseUrl/api/userInvite/sendInvite';
  static String eventList = '$baseUrl/content/api/event/getEvent?page=';
  static String event = '$baseUrl/content/api/event/getById/';
  static String mentorList = '$baseUrl/user/api/user/getMentors';
  static String mentorDetails = '$baseUrl/user/api/user/getMentorDetailsById/';
  static String needAssistance = '$baseUrl/user/api/assistance/needAssistance';
  static String bookSession = '$baseUrl/user/api/user/scheduleSession';
  static String totalCoin = '$baseUrl/user/api/rewards/getCount';
  static String coinHistory = '$baseUrl/user/api/rewards/get';
  static String verifyEmail = '$baseUrl/api/user/verifyEmail';
  static String roadmapCompletion = '$baseUrl/user/api/userRoadmapJourney/getRoadmapJourneyCompletion';
  static String redeemRewards = '$baseUrl/user/api/rewards/redeem-coins?eventId=';

  static String getInternshipList = '$baseUrl/content/api/internship/getInternshipList';
  static String getInternshipDetail = '$baseUrl/content/api/internship/getInternshipById/';
  static String savedInternship = '$baseUrl/content/api/internship/saveInternshipInterest';
  static String getMetaData = '$baseUrl/content/api/metadata/getMetadata?page=';

  //roadmap
  static String getOnBoardingJourney = '$baseUrl/user/api/userOnboardJourney/getJourney';
  static String updateOnBoardingJourney = '$baseUrl/user/api/userOnboardJourney/updateJourney';
  static String getOnBoardingAssessment = '$baseUrl/content/api/assessment/getAssessmentById/';
  static String onBoardingAnswerSubmission = '$baseUrl/user/api/userOnboardJourney/assessmentAnswers';
  static String getRoadmapJourneys = '$baseUrl/user/api/userRoadmapJourney/getJourneys';
  static String getRoadMapById = '$baseUrl/user/api/userRoadmapJourney/getRoadmap/';
  static String getQuiz = '$baseUrl/content/api/quiz/getQuizById/';
  static String submitQuiz = '$baseUrl/user/api/userRoadmapJourney/quizAnswers';
  static String getQuizResult = '$baseUrl/user/api/userRoadmapJourney/quizResult';
  static String getAllRoadMap = '$baseUrl/user/api/userRoadmapJourney/getAllRoadmap';
  static String verifySubscription = '$baseUrl/user/api/userOnboardJourney/redeem-code';

  static String updateRoadmapJourney = '$baseUrl/user/api/userRoadmapJourney/updateProgress';
}
