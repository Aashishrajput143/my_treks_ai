enum RoadMapContentType {
  articlePdf("Article PDF"),
  articleWriteup("Article writeup"),
  nativeVideoLink("Native video link"),
  youtubeVideoLink("Youtube video link"),
  journalLink("Journal Link"),
  articleLink("Article Link"),
  assignment("Assignment");

  final String value;
  const RoadMapContentType(this.value);
}

enum OnBoardingRoadMapContentType {
  onBoardVideo("ONBOARD_VIDEO"),
  nativeVideo("NATIVE_VIDEO"),
  assessment("ASSESSMENT"),
  youtubeVideo("YOUTUBE_VIDEO"),
  gallupVideo("GALLUP_VIDEO"),
  coachVideo("COACH_INTRO_VIDEO"),
  userInviteGallupCode("USER_INVITE_GALLUP_CODE"),
  gallupResult("GALLUP_RESULT"),
  scheduleCoachmeeting("SCHEDULE_COACH_MEETING"),
  softSkillAssessment("SOFT_SKILL_ASSESSMENT");

  final String value;
  const OnBoardingRoadMapContentType(this.value);
}

enum RoadmapMetaDataTags {
  career("CAREER"),
  industry("INDUSTRY"),
  softSkills("SOFT SKILLS"),
  strength("STRENGTHS");

  final String value;
  const RoadmapMetaDataTags(this.value);
}

enum MediaLibraryType {
  profile("PROFILE"),
  gallupResult("GALLUP_RESULT"),
  roadmapAssignment("ROADMAP_ASSIGNMENT");

  final String value;
  const MediaLibraryType(this.value);
}

enum FileExtentions {
  iamge("IMAGE"),
  excel("EXCEL"),
  csv("CSV"),
  pdf("PDF");

  final String value;
  const FileExtentions(this.value);
}

enum EventStatus {
  upcoming("UPCOMING"),
  inProgress("IN_PROGRESS"),
  complete("COMPLETED"),
  cancelled("CANCELLED");

  final String value;
  const EventStatus(this.value);
}
