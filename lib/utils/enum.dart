enum AppTheme {
  dark,
  light,
}

enum TimeFrame {
  oneHour,
  twoHours,
  threeHours,
  fourHours,
  oneDay,
  oneWeek,
  oneMonth,
  oneYear,
}

String getTimeFrameText(TimeFrame timeFrame) {
  switch (timeFrame) {
    case TimeFrame.oneHour:
      return "1h";
    case TimeFrame.twoHours:
      return "2h";

    case TimeFrame.threeHours:
      return "3h";
    case TimeFrame.fourHours:
      return "4h";

    case TimeFrame.oneDay:
      return "1d";
    case TimeFrame.oneWeek:
      return "1w";

    case TimeFrame.oneMonth:
      return "1m";
    case TimeFrame.oneYear:
      return "1y";

    default:
      return "1h";
  }
}

TimeFrame getTimeFrameFromText(String text) {
  switch (text) {
    case "1h":
      return TimeFrame.oneHour;

    case "2h":
      return TimeFrame.twoHours;
    case "3h":
      return TimeFrame.threeHours;

    case "4h":
      return TimeFrame.fourHours;
    case "1d":
      return TimeFrame.oneDay;

    case "1w":
      return TimeFrame.oneWeek;
    case "1m":
      return TimeFrame.oneMonth;
    case "1y":
      return TimeFrame.oneYear;

    default:
      return TimeFrame.oneHour;
  }
}
