class Notice {
  int idSite;
  String title;
  String subtitle;
  String url;
  DateTime publicationDate;
  String publicationDateString;
  String campus;

  Notice({
    required this.idSite,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.publicationDate,
    required this.publicationDateString,
    required this.campus,
  });

  factory Notice.fromJson(Map json) => Notice(
        idSite: json["idSite"],
        title: json["title"],
        subtitle: json["subtitle"],
        url: json["url"],
        publicationDate: json["dataPublicacao"] != null
            ? DateTime.parse(json["dataPublicacao"])
            : _dateStringToDate(json["dateString"]),
        publicationDateString: json["dateString"],
        campus: json["campus"],
      );

  factory Notice.fromDb(Map db) => Notice(
        idSite: db["id_site"],
        title: db["title"],
        subtitle: db["subtitle"],
        url: db["url"],
        publicationDate:
            DateTime.fromMillisecondsSinceEpoch(db["publication_date"]),
        publicationDateString: db["publication_date_string"],
        campus: db["campus"],
      );

  static DateTime _dateStringToDate(String dateString) {
    List<String> slices = dateString.split(", ");

    List<String> dayMonthYearString = slices[1].split(" de ");
    List<String> hourMinuteString = slices[2].split("h");

    String dayString = dayMonthYearString[0];
    String monthString = dayMonthYearString[1];
    String yearString = dayMonthYearString[2];

    String hourString = hourMinuteString[0];
    String minuteString = hourMinuteString[1];

    Map<String, int> months = {
      "Jan": 1,
      "Janeiro": 1,
      "Fev": 2,
      "Fevereiro": 2,
      "Mar": 3,
      "Março": 3,
      "Abr": 4,
      "Abril": 4,
      "Mai": 5,
      "Maio": 5,
      "Jun": 6,
      "Junho": 6,
      "Jul": 7,
      "Julho": 7,
      "Ago": 8,
      "Agosto": 8,
      "Set": 9,
      "Setembro": 9,
      "Out": 10,
      "Outubro": 10,
      "Nov": 11,
      "Novembro": 11,
      "Dez": 12,
      "Dezembro": 12
    };

    int day = int.parse(dayString);
    int month = months[monthString]!;
    int year = yearString == '-0001' ? 2015 : int.parse(yearString);
    int hour = int.parse(hourString);
    int minute = int.parse(minuteString);

    DateTime dateTime = DateTime(year, month, day, hour, minute);

    return dateTime;
  }
}
