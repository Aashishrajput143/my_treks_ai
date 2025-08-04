
import 'package:get/get.dart';
import 'package:vroar/modules/controller/common_screen_controller.dart';

class ParentHomeController extends GetxController {
  var greetings ="".obs;

  final CommonScreenController mainController = Get.put(CommonScreenController());

  @override
  void onInit() {
    super.onInit();
    setGreeting();
  }

  void setGreeting(){
    String time = DateTime.now().toString();
    time=time.split(" ")[1].toString();
    time =time.split(".")[0].toString();
    print(time);
    DateTime timeNow=DateTime.parse("2000-01-01 $time");
    DateTime morningStart=DateTime.parse("2000-01-01 05:00:00");
    DateTime morningEnd=DateTime.parse("2000-01-01 11:59:59");
    DateTime afternoonStart=DateTime.parse("2000-01-01 12:00:00");
    DateTime afternoonEnd=DateTime.parse("2000-01-01 16:59:59");
    DateTime eveningStart=DateTime.parse("2000-01-01 17:00:00");
    DateTime eveningEnd=DateTime.parse("2000-01-01 20:59:59");
    if(timeNow.isAfter(morningStart) && timeNow.isBefore(morningEnd)){
      greetings.value="Good Morning";
    }else if(timeNow.isAfter(afternoonStart)&& timeNow.isBefore(afternoonEnd)){
      greetings.value="Good Afternoon";
    }
    else if(timeNow.isAfter(eveningStart)&& timeNow.isBefore(eveningEnd)){
      greetings.value="Good Evening";
    }else{
      greetings.value="Good Night";
    }
  }
}
