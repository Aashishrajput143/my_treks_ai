

import 'package:get/get.dart';
import 'package:vroar/modules/controller/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
