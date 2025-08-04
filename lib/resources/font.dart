class AppFonts {



  static final AppFonts appFonts =  AppFonts._internal();
  factory AppFonts() {
    return appFonts;
  }
  AppFonts._internal();

  get robots => 'RobotoSlab';
  get robotsRegular => 'RobotsRegular';
  get NunitoRegular => 'NunitoRegular';
  get NunitoLight => 'NunitoLight';
  get NunitoMedium => 'NunitoMedium';
  get NunitoBold => 'NunitoBold';
  get SpaceGroteskBold => 'SpaceGroteskBold';
  get PlusJakartaSansRegular => 'PlusJakartaSansRegular';

}
AppFonts appFonts =  AppFonts();
