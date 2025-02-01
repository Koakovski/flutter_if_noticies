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
        publicationDate: DateTime.parse(json["dataPublicacao"]),
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
}
