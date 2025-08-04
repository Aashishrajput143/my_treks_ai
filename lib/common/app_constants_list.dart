import 'package:get/get.dart';

import '../resources/colors.dart';

class AppConstantsList {
  static final List<String> relationOptions = ['Parent', 'Father', 'Mother', 'Guardian', 'Other'].obs;
  static final List<String> filters = [
    "Technology",
    "Information Technology",
    "Education",
    "Medical Research",
    "Software Development",
    "Educational Administration",
  ].obs;
  static final List<String> banners = ['Creative Writing \nWorkshop', 'Photography Masterclass \nWorkshop', 'Design Thinking \nSession'];
  static final List<String> time = ['7th Feb, 2025 | 1:00-3:00 PM', '12th Feb, 2025 | 5:00-7:00 PM', '16th Feb, 2025 | 12:00-2:00 PM'];

  static final List<String> sessionTime = [
    '2:00 PM',
    '2:15 PM',
    '2:30 PM',
    '2:45 PM',
  ];
  static final List<String> issueType = [
    'Technical Problem',
    'Connectivity Issue',
    'User Interface Problem',
    'Other',
  ].obs;

  static final List<Map<String, dynamic>> randomButton = [
    {"light": appColors.yellowLightColorButton, "dark": appColors.yellowDarkColorButton, },
    {"light": appColors.blueLightColorButton, "dark": appColors.blueDarkColorButton, },
    {"light": appColors.greenLightColorButton, "dark": appColors.greenDarkColorButton,},
    {"light": appColors.pinkLightColorButton, "dark": appColors.pinkDarkColorButton, },
    {"light": appColors.orangeLightColorButton, "dark": appColors.contentAccent, },
  ];

  static final List<Map<String, dynamic>> carouselSliderColor = [
    {"light": appColors.carouselSliderLightColor, "dark": appColors.carouselSliderDarkColor, },
    {"light": appColors.greenLightAccentColor, "dark": appColors.accentGreen, },
    {"light": appColors.orangeLightColorButton, "dark": appColors.orangeDarkAccentColor,},
  ];

  static final List<String> genderOptions = ['Male', 'Female', 'Other'].obs;
  static final List<String> gradeOptions = ['8th', '9th', '10th', '11th', '12th', 'Homeschooled'].obs;
  static final List<String> careerStrength = ['Healthcare', 'Technology', 'Communication', 'Education', 'Law', 'Creative Arts', 'Science & Research', 'Business & Management', 'Engineering', 'Communications & Media'].obs;
  static final List<String> industryStrength = ['Healthcare', 'Technology', 'Communication', 'Education', 'Law', 'Creative Arts', 'Science & Research', 'Business & Management', 'Engineering', 'Communications & Media'].obs;
  static final List<String> selectStrength = ['Leadership', 'Creativity', 'Problem-Solving', 'Critical Thinking', 'Knowledgeable', 'Artistic', 'Teamwork', 'Analytical', 'Communication', 'Innovative'].obs;
  static final List<String> skillStrength = ['Communication', 'Teamwork', 'Adaptability', 'Leadership', 'Time Management'].obs;

  static final List<String> topStrength = [
    'Achiever',
    'Activator',
    'Adaptability',
    'Analytical',
    'Arranger',
    'Belief',
    'Command',
    'Communication',
    'Competition',
    'Connectedness',
    'Consistency',
    'Context',
    'Deliberative',
    'Developer',
    'Discipline',
    'Empathy',
    'Focus',
    'Futuristic',
    'Harmony',
    'Ideation',
    'Includer',
    'Individualization',
    'Input',
    'Intellection',
    'Learner',
    'Maximizer',
    'Positivity',
    'Relator',
    'Responsibility',
    'Restorative',
    'Self-Assurance',
    'Significance',
    'Strategic',
    'Woo (Winning Others Over)'
  ].obs;

}
