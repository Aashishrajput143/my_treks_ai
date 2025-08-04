

import 'package:get/get.dart';
import 'package:vroar/modules/controller/common_screen_controller.dart';

class CommonScreenBindings extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => CommonScreenController());
  }

}
