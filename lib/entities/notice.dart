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

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        idSite: json["idSite"],
        title: json["title"],
        subtitle: json["subtitle"],
        url: json["url"],
        publicationDate: DateTime.parse(json["dataPublicacao"]),
        publicationDateString: json["dateString"],
        campus: json["campus"],
      );
}
