import 'package:get/get.dart';

import '../common/roadmap_common_widgets/pdf_viwer.dart';
import '../modules/bindings/notification_bindings.dart';
import '../modules/screen/book_session.dart';
import '../modules/screen/common_screen.dart';
import '../modules/screen/forget_password_email.dart';
import '../modules/screen/home_screen.dart';
import '../modules/screen/internship_details.dart';
import '../modules/screen/login_screen.dart';
import '../modules/screen/mentor_details.dart';
import '../modules/screen/mentor_onboarding_screen.dart';
import '../modules/screen/mentor_signup_screen.dart';
import '../modules/screen/need_assistance.dart';
import '../modules/screen/parent_invitation_sucess.dart';
import '../modules/screen/parent_invite.dart';
import '../modules/screen/parent_onboarding_screen.dart';
import '../modules/screen/parent_signup_screen.dart';
import '../modules/screen/roadmap/question_answer_screen.dart';
import '../modules/screen/roadmap/quiz.dart';
import '../modules/screen/roadmap/quiz_answers.dart';
import '../modules/screen/roadmap/quiz_completed.dart';
import '../modules/screen/roadmap/onboarding_roadmap_screen.dart';
import '../modules/screen/roadmap/roadmap_screen.dart';
import '../modules/screen/roadmap/write_assignment.dart';
import '../modules/screen/select_path.dart';
import '../modules/screen/session_details.dart';
import '../modules/screen/signup_details.dart';
import '../modules/screen/splash_screen.dart';
import '../modules/screen/student_invite.dart';
import '../modules/screen/student_signup_screen.dart';
import '../modules/screen/student_onboarding_screen.dart';
import '../modules/screen/user_role_screen.dart';
import '../modules/screen/notification_screen.dart';
import '../modules/screen/verificationCode.dart';
import '../modules/screen/forget_password.dart';
import '../modules/screen/onboarding_screen.dart';
import '../modules/screen/success_password.dart';
import '../modules/screen/roadmap/top_strength.dart';

class RoutesClass {
  //BR1
  static String onBoardingScreen = '/onboardingscreen';
  static String login = '/login';
  static String userRole = '/userRole';
  static String studentOnBoardingScreen = '/studentOnBoardingScreen';
  static String parentOnBoardingScreen = '/parentOnBoardingScreen';
  static String mentorOnBoardingScreen = '/mentorOnBoardingScreen';
  static String studentSignUpScreen = '/studentSignUpScreen';
  static String parentSignUpScreen = '/parentSignUpScreen';
  static String mentorSignUpScreen = '/mentorSignUpScreen';
  static String forgetPasswordEmail = '/forgetPasswordEmail';
  static String forgetPassword = '/forgetPassword';
  static String forgetPasswordSuccess = '/forgetPasswordSuccess';
  static String signUpDetails = '/signUpDetails';
  static String parentInvite = '/parentInvite';
  static String verificationCode = '/verificationCode';
  static String parentInviteSuccess = '/parentInviteSuccess';
  static String studentInvite = '/studentInvite';
  static String questionAnswer = '/questionAnswer';
  static String quizScreen = '/quizScreen';
  static String quizAnswersScreen = '/quizAnswersScreen';
  static String quizCompleted = '/quizCompleted';
  static String eventDetails = '/eventDetails';
  static String needAssistance = '/needAssistance';

  static String internshipDetails = '/internshipDetails';
  static String mentorDetails = '/mentorDetails';
  static String bookSession = '/bookSession';

  static String strengthScreen = '/strengthScreen';
  static String splashScreen = '/splashScreen';
  static String selectPath = '/selectPath';

  static String home = '/home';
  static String roadMap = '/roadMap';
  static String pdfViewScreen = '/pdfViewScreen';
  static String onBoardingRoadMap = '/onBoardingRoadMap';
  static String articleWriteup = '/articleWriteup';
  static String commonScreen = '/commonScreen';
  static String notification = '/notification';

  //BR1
  static String gotoOnBoardingScreen() => onBoardingScreen;
  static String gotoLoginScreen() => login;
  static String gotoUserRoleScreen() => userRole;
  static String gotoStudentOnBoardingScreen() => studentOnBoardingScreen;
  static String gotoParentOnBoardingScreen() => parentOnBoardingScreen;
  static String gotoMentorOnBoardingScreen() => mentorOnBoardingScreen;
  static String gotoStudentSignUpScreen() => studentSignUpScreen;
  static String gotoParentSignUpScreen() => parentSignUpScreen;
  static String gotoMentorSignUpScreen() => mentorSignUpScreen;
  static String gotoForgetPasswordEmailScreen() => forgetPasswordEmail;
  static String gotoForgetPasswordScreen() => forgetPassword;
  static String gotoForgetPasswordSuccessScreen() => forgetPasswordSuccess;
  static String gotoSignUpDetailsScreen() => signUpDetails;
  static String gotoParentInviteScreen() => parentInvite;
  static String gotoVerificationCodeScreen() => verificationCode;
  static String gotoParentInviteSuccessScreen() => parentInviteSuccess;
  static String gotoStudentInviteScreen() => studentInvite;
  static String gotoQuestionAnswerScreen() => questionAnswer;
  static String gotoQuizScreen() => quizScreen;
  static String gotoQuizCompletedScreen() => quizCompleted;
  static String gotoQuizAnswersScreen() => quizAnswersScreen;
  static String gotoStrengthScreen() => strengthScreen;
  static String gotoSplashScreen() => splashScreen;
  static String gotoSelectPathScreen() => selectPath;
  static String gotoInternshipDetailsScreen() => internshipDetails;
  static String gotoMentorDetailsScreen() => mentorDetails;
  static String gotoEventDetailsScreen() => eventDetails;
  static String gotoNeedAssistanceScreen() => needAssistance;

  static String gotoHome() => home;
  static String gotoRoadMap() => roadMap;
  static String gotoPdfViewScreen() => pdfViewScreen;
  static String gotoOnBoardingRoadMap() => onBoardingRoadMap;
  static String gotArticleWriteUo() => articleWriteup;
  static String gotoCommonScreen() => commonScreen;
  static String gotoNotificationScreen() => notification;

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: onBoardingScreen,
      page: () => const OnBoardingScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: userRole,
      page: () => const UserRoleScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: mentorDetails,
      page: () => const MentorDetailsScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: bookSession,
      page: () => const BookSessionScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: internshipDetails,
      page: () => const InternshipDetailsScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: studentOnBoardingScreen,
      page: () => const StudentOnBoardingScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: parentOnBoardingScreen,
      page: () => const ParentOnBoardingScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: mentorOnBoardingScreen,
      page: () => const MentorOnBoardingScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: studentSignUpScreen,
      page: () => const StudentSignUpScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: parentSignUpScreen,
      page: () => const ParentSignUpScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: mentorSignUpScreen,
      page: () => const MentorSignUpScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: forgetPasswordEmail,
      page: () => const ForgotPasswordEmailScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: eventDetails,
      page: () => const SessionDetailsScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: forgetPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: forgetPasswordSuccess,
      page: () => const SuccessPasswordScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: needAssistance,
      page: () => const NeedAssistanceScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: signUpDetails,
      page: () => const SignupDetailsScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: parentInvite,
      page: () => const ParentInviteScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: verificationCode,
      page: () => const VerificationCodeScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: parentInviteSuccess,
      page: () => const ParentInvitationSuccessScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: studentInvite,
      page: () => const StudentInviteScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: questionAnswer,
      page: () => const QuestionAnswerScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: quizCompleted,
      page: () => const QuizCompletedScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: quizScreen,
      page: () => const QuizScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: quizAnswersScreen,
      page: () => const QuizAnswersScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: strengthScreen,
      page: () => const TopStrengthScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: roadMap,
      page: () => const RoadmapScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: selectPath,
      page: () => const SelectPathScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: onBoardingRoadMap,
      page: () => const OnBoardingRoadmapScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: pdfViewScreen,
      page: () => const PDFScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: commonScreen,
      page: () => const CommonScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(name: notification, page: () => const NotificationScreen(), transition: Transition.zoom, transitionDuration: const Duration(milliseconds: 300), binding: NotificationBinding()),
    GetPage(name: articleWriteup, page: () => const WriteAssignmentScreen(), transition: Transition.zoom, transitionDuration: const Duration(milliseconds: 300), binding: NotificationBinding()),
  ];
}
