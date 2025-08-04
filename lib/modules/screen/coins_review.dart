import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/utils/sized_box_extension.dart';
import '../../common/common_shimmer.dart';
import '../../common/common_widgets.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../controller/coins_review_controller.dart';

class CoinsReviewScreen extends ParentWidget {
  const CoinsReviewScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final CoinsReviewController coinsController = Get.put(CoinsReviewController());
    return GetBuilder<CoinsReviewController>(
        init: CoinsReviewController(),
        initState: (state) {
          if (state.mounted) {
            coinsController.getTotalCoinApi();
            coinsController.getCoinHistoryApi();
            coinsController.getEventListApi();
          }
        },
        builder: (controller) {
          return Obx(
            () => Stack(children: [
              Scaffold(
                appBar: AppBar(
                    surfaceTintColor: Colors.white,
                    title: Text(appStrings.coins, style: TextStyle(fontSize: 24, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    centerTitle: true,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(170),
                      //preferredSize: Size.fromHeight(h * 0.37),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.totalCoinData.value.data?.totalCoinEarn != null ? coinCard(h, w, controller) : shimmerRoundedLine(w, h * 0.2),
                            SizedBox(height: h * 0.02),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     commonSearchField(
                            //       controller.searchController.value,
                            //       controller.searchFocusNode.value,
                            //       w * 0.76,
                            //       (value) {},
                            //       hint: appStrings.searchForItems,
                            //       contentPadding: 14,
                            //       inputFormatters: [
                            //         NoLeadingSpaceFormatter(),
                            //         RemoveTrailingPeriodsFormatter(),
                            //         SpecialCharacterValidator(),
                            //         EmojiInputFormatter(),
                            //         LengthLimitingTextInputFormatter(30)
                            //       ],
                            //     ),
                            //     InkWell(
                            //       onTap: () {
                            //         //controller.showFilterDialog(context, w);
                            //       },
                            //       child: Container(
                            //         width: w * 0.145,
                            //         height: h * 0.062,
                            //         decoration: BoxDecoration(
                            //           color: Colors.white,
                            //           borderRadius: BorderRadius.circular(12),
                            //           border:
                            //               Border.all(color: appColors.border), // Outer border
                            //         ),
                            //         child: Icon(
                            //           Icons.filter_list,
                            //           color: appColors.contentPrimary,
                            //           size: 30,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // commonSearchField(
                            //   controller.searchController.value,
                            //   controller.searchFocusNode.value,
                            //   w,
                            //   (value) {},
                            //   hint: appStrings.searchForItems,
                            //   contentPadding: 14,
                            //   inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(30)],
                            // ),
                            // SizedBox(height: h * 0.02),
                            // buttons(h, w, controller)
                            // Text("Earned Rewards", style: TextStyle(fontSize: 24, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                    )),
                body: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                  child: controller.eventListData.value.data != null
                      ? controller.eventListData.value.data?.docs?.isNotEmpty ?? false
                          ? getEvent(controller, w, h)
                          : getEmptyCoinsHistory(controller)
                      : SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: List.generate(
                              8,
                              (index) => shimmerCoinHistory(w, 50),
                            ),
                          ),
                        ),
                ),
              ),
              //progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
            ]),
          );
        });
  }

  Widget coinCard(h, w, controller) {
    return Stack(
      children: [
        Container(
          height: 152,
          width: w,
          decoration: BoxDecoration(
            color: appColors.contentAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            appImages.maskGroup,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 10,
          right: 0,
          child: SvgPicture.asset(
            appImages.bigCoins,
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appStrings.totalPointsEarned,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: appFonts.NunitoBold,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "${controller.totalCoinData.value.data?.totalCoinEarn ?? 0}",
                        style: TextStyle(
                          fontSize: getDynamicFontSize(controller.totalCoinData.value.data?.totalCoinEarn ?? 0),
                          color: Colors.white,
                          fontFamily: appFonts.NunitoBold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        appStrings.pTS,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: appFonts.NunitoBold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double getDynamicFontSize(int value) {
    int length = value.toString().length;

    if (length <= 3) return 52;
    if (length == 4) return 48;
    if (length == 5) return 44;
    if (length == 6) return 40;
    if (length == 7) return 36;
    return 32; // fallback for 8+ digits
  }

  Widget getEvent(CoinsReviewController controller, w, h) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            height: 55,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(color: appColors.accentBlue, borderRadius: BorderRadius.circular(42)),
            child: TabBar(
              padding: EdgeInsets.zero,
              indicatorColor: Colors.transparent,
              splashBorderRadius: BorderRadius.circular(30),
              dividerColor: Colors.transparent,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: appColors.contentAccent,
              unselectedLabelColor: appColors.contentPrimary,
              indicator: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(42), border: Border.all(color: appColors.border)),
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: appFonts.NunitoBold),
              unselectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: appFonts.NunitoBold),
              tabs: [
                Tab(child: Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Text(appStrings.rewards)))),
                Tab(child: Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Text(appStrings.claimedPoints)))),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                buildEventList(controller, w, h),
                buildEventHistoryList(controller, w, h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEventList(controller, w, h) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: controller.eventListData.value.data?.docs?.length ?? 0,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [buildEventCard(index, controller, w, h, context), const SizedBox(height: 10), if (index < (controller.eventListData.value.data?.docs?.length ?? 1) - 1) Divider(color: appColors.border, thickness: 1.2)],
        );
      },
    );
  }

  Widget buildEventCard(index, CoinsReviewController controller, w, h, context) {
    final eventData = controller.eventListData.value.data?.docs?[index];
    final event = controller.dataEvent[index];
    return InkWell(
      splashColor: appColors.transparentColor,
      onTap: () => Get.toNamed(RoutesClass.eventDetails, arguments: {'index': index, 'id': eventData?.id, "eventType": "PAID", 'Tag': event["title"]}),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: SvgPicture.asset(
            event["title"] == "Webinar"
                ? appImages.webinar
                : event["title"] == "On-Field Workshop"
                    ? appImages.onFieldWorkshop
                    : appImages.mentorSession,
            width: 30,
            height: 30,
            fit: BoxFit.fill),
        title:
            // event["title"] == "Mentor Session"?
            Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            eventData?.eventName ?? event["title"],
            style: TextStyle(fontSize: 14, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        )
        // : Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
        //     commonColorTags(
        //         event["title"] == "Webinar"
        //             ? appColors.yellowLightColorButton
        //             : event["title"] == "On-Field Workshop"
        //                 ? appColors.blueLightColorButton
        //                 : appColors.blueLightColorButton,
        //         event["title"] == "Webinar"
        //             ? appColors.yellowDarkColorButton
        //             : event["title"] == "On-Field Workshop"
        //                 ? appColors.blueDarkColorButton
        //                 : appColors.blueDarkColorButton,
        //         //radius: 30,
        //         fontSize: 11,
        //         padding: 4,
        //         bold: true,
        //         hint: event["title"]),
        //     4.kW,
        //     Text("• ${controller.getDate(eventData?.createdAt ?? "0")}", style: TextStyle(fontSize: 11, color: appColors.contentSecondary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
        //   ])
        ,
        subtitle:
            // event["title"] != "Mentor Session"?
            Container(
                padding: const EdgeInsets.only(top: 6),
                width: w * 0.6,
                child: Text("${controller.getDate(eventData?.sessionStartDate ?? '000')} ${eventData?.sessionStartTime}", style: TextStyle(fontSize: 14, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.start))
        // : Text(
        //     controller.getDate(eventData?.createdAt ?? "0"),
        //     style: TextStyle(fontSize: 14, color: appColors.contentSecondary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold),
        //     textAlign: TextAlign.start,
        //   )
        ,
        trailing: SizedBox(
          width: w * 0.2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: SvgPicture.asset(appImages.bigCoins, width: 24, height: 24, fit: BoxFit.contain),
                  ),
                  4.kW,
                  Text(
                    "${(eventData?.coins.toString().length ?? 0) > 4 ? ("${eventData?.coins.toString().substring(0, 4) ?? "0"}...") : eventData?.coins ?? 0}",
                    style: TextStyle(fontSize: 15, color: appColors.contentAccent, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              4.kH,
              SizedBox(
                height: 25,
                child: commonButton(
                    w * 0.22,
                    30, // Reduced height
                    Colors.white,
                    Colors.green[700]!, () {
                  Get.toNamed(
                    RoutesClass.eventDetails,
                    arguments: {'index': index, 'id': eventData?.id, "eventType": "PAID", 'Tag': event["title"]},
                  );
                }, hint: appStrings.redeem, radius: 5, borderColor: Colors.green[700]!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEventHistoryList(CoinsReviewController controller, w, h) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: controller.coinHistoryData.value.data?.docs?.length ?? 0,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [buildEventHistoryCard(index, controller, w, h, context), const SizedBox(height: 10), if (index < (controller.coinHistoryData.value.data?.docs?.length ?? 1) - 1) Divider(color: appColors.border, thickness: 1.2)],
        );
      },
    );
  }

  Widget buildEventHistoryCard(index, CoinsReviewController controller, w, h, context) {
    final eventHistory = controller.coinHistoryData.value.data?.docs?[index];
    final event = controller.dataEvent[index];
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: SvgPicture.asset(
          event["title"] == "Webinar"
              ? appImages.webinar
              : event["title"] == "On-Field Workshop"
                  ? appImages.onFieldWorkshop
                  : appImages.mentorSession,
          width: 30,
          height: 30,
          fit: BoxFit.fill),
      // title:
      //     //  event["title"] == "Mentor Session"?
      //     Padding(padding: const EdgeInsets.only(bottom: 5.0), child: Text(event["title"], style: TextStyle(fontSize: 14, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.start))
      // : Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      //     commonColorTags(
      //         event["title"] == "Webinar"
      //             ? appColors.yellowLightColorButton
      //             : event["title"] == "On-Field Workshop"
      //                 ? appColors.blueLightColorButton
      //                 : appColors.blueLightColorButton,
      //         event["title"] == "Webinar"
      //             ? appColors.yellowDarkColorButton
      //             : event["title"] == "On-Field Workshop"
      //                 ? appColors.blueDarkColorButton
      //                 : appColors.blueDarkColorButton,
      //         //radius: 30,
      //         fontSize: 11,
      //         padding: 4,
      //         bold: true,
      //         hint: event["title"]),
      //     4.kW,
      //     Text("• ${controller.getDate(eventHistory?.createdAt ?? "0")}", style: TextStyle(fontSize: 11, color: appColors.contentSecondary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      //   ]),
      subtitle:
          // event["title"] != "Mentor Session"?
          Container(
        padding: const EdgeInsets.only(top: 6),
        width: w * 0.6,
        child: Text(
          eventHistory?.description ?? "",
          style: TextStyle(fontSize: 14, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
      )
      // : Text(controller.getDate(eventHistory?.createdAt ?? "0"), style: TextStyle(fontSize: 14, color: appColors.contentSecondary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.start)
      ,
      trailing: SizedBox(
        width: w * 0.2,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SvgPicture.asset(appImages.bigCoins, width: 30, height: 30, fit: BoxFit.fill),
                ),
                Text(
                  (eventHistory?.rewardValue ?? 0) <= 0 ? "0" : " -${eventHistory?.rewardValue ?? 0}",
                  style: TextStyle(fontSize: 16, color: appColors.contentAccent, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCoinsHistory(coinsController, w, h) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: coinsController.coinHistoryData.value.data?.docs?.length ?? 0,
      itemBuilder: (context, index) {
        final coins = coinsController.coinHistoryData.value.data?.docs?[index];
        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              title: Row(
                children: [
                  commonColorTags(coins?.earnedFrom == "ADMIN" ? appColors.yellowLightColorButton : appColors.blueLightColorButton, coins?.earnedFrom == "ADMIN" ? appColors.yellowDarkColorButton : appColors.blueDarkColorButton,
                      fontSize: 12, vPadding: 2, padding: 16, radius: 10, bold: true, hint: coins?.earnedFrom == "ADMIN" ? "ADMIN" : "Claimed"),
                  10.kW,
                  Text(
                    "• ${coinsController.getDate(coins?.createdAt ?? "0")}",
                    style: TextStyle(fontSize: 11, color: appColors.contentSecondary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  coins?.description ?? "",
                  style: TextStyle(fontSize: 14, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              trailing: SizedBox(
                width: w * 0.24, // Adjust as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SvgPicture.asset(appImages.bigCoins, width: 30, height: 30, fit: BoxFit.fill),
                    ),
                    3.kW,
                    Text("${(coins?.rewardValue ?? 0) < 0 ? '' : '+'}${coins?.rewardValue ?? 0}",
                        style: TextStyle(fontSize: 16, color: appColors.contentAccent, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            6.kH,
            index == ((coinsController.coinHistoryData.value.data?.docs?.length ?? 0) - 1) ? const SizedBox(height: 6) : Divider(color: appColors.border, thickness: 1.2),
          ],
        );
      },
    );
  }

  Widget getEmptyCoinsHistory(CoinsReviewController controller) {
    return Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: Get.height > 677 ? Get.height * 0.04 : 0),
            child: Column(
              children: [
                SvgPicture.asset(appImages.emptyWallet, width: 150, height: 150),
                Text("No rewards available for redeem", style: TextStyle(fontSize: 25, color: appColors.contentAccent, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                8.kH,
                Text("Came back later for redeem rewards!", style: TextStyle(fontSize: 14, color: appColors.contentPrimary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                10.kH,
                // commonButton(180, 50, appColors.contentAccent, Colors.white, () {
                //   controller.commonScreenController.selectedIndex.value = 1;
                // }, hint: "Go to RoadMap", radius: 30),
              ],
            )));
  }
}
