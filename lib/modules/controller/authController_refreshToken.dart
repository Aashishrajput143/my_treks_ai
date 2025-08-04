import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../common/Constants.dart';
import '../../data/app_url/app_url.dart';
import '../../utils/utils.dart';
import '../screen/tokenRefreshInterceptor.dart';

class AuthController extends GetxController {
  final Dio dio = Dio();
  RxString accessToken = ''.obs;
  RxString refreshToken = ''.obs;

  @override
  Future<void> onInit() async {
    accessToken.value = await Utils.getPreferenceValues(Constants.accessToken) ?? '';
    Utils.printLog("Access Token: ${accessToken.value}");
    refreshToken.value = await Utils.getPreferenceValues(Constants.refreshToken) ?? '';
    Utils.printLog("Refresh Token: ${refreshToken.value}");

    init();

    super.onInit();
  }

  void init() {
    // Add the interceptor to Dio instance
    dio.interceptors.add(TokenRefreshInterceptor(dio, this));
  }

  Future<void> refreshTokenApi() async {
    try {
      final response = await dio.post(
        AppUrl.refreshToken,
        data: {
          'refreshToken': refreshToken.value,
          'accessToken': accessToken.value,
        },
      );

      if (response.statusCode == 200) {
        accessToken.value = response.data['accessToken'];
        refreshToken.value = response.data['refreshToken'];

        // Save tokens to preferences (if needed)
        Utils.savePreferenceValues(Constants.accessToken, accessToken.value);
        Utils.savePreferenceValues(Constants.refreshToken, refreshToken.value);
      } else {
        throw Exception("Token refresh failed with status: ${response.statusCode}");
      }
    } catch (e) {
      Utils.printLog("Error in refreshTokenApi: $e");
      throw Exception("Token refresh failed: $e");
    }
  }
}
