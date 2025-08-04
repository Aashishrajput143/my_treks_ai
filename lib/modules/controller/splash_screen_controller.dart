import 'package:get/get.dart';

import '../../common/Constants.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    navigate();
  }

  Future<void> navigate() async {
    print(await Utils.getPreferenceValues(Constants.role));
    print(await Utils.getPreferenceValues(Constants.refreshToken));
    Utils.savePreferenceValues(Constants.refreshLogin, "Yes");
    String role = await Utils.getPreferenceValues(Constants.role) ?? "";
    Utils.getPreferenceValues(Constants.isOnBoarding).then((value) => {
          Utils.printLog("is Onboarding $value"),
          // Get.offAllNamed(RoutesClass.onBoardingRoadMap),
          if (value != "" && value != null)
            {
              Utils.getPreferenceValues(Constants.accessToken).then((value) => {
                    Utils.printLog("token $value"),
                    if (value != "" && value != null)
                      {
                        if (role.isNotEmpty)
                          {
                            Future.delayed(const Duration(seconds: 4), () {
                              Get.offAllNamed(RoutesClass.commonScreen,
                                  arguments: role);
                            }),
                          }
                        else
                          {
                            Future.delayed(const Duration(seconds: 4), () {
                              Get.offAllNamed(RoutesClass.login);
                            }),
                          },
                        print(value)
                      }
                    else
                      {
                        Future.delayed(const Duration(seconds: 4), () {
                          Get.offAllNamed(RoutesClass.login);
                        }),
                      }
                  })
            }
          else
            {
              Future.delayed(const Duration(seconds: 4), () {
                Get.offAllNamed(RoutesClass.onBoardingScreen);
              }),
            }
        });
  }
}
