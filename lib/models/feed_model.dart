// To parse this JSON data, do
//
//     final feed = feedFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

Feed feedFromJson(String str) => Feed.fromJson(json.decode(str));

String feedToJson(Feed data) => json.encode(data.toJson());

class Feed {
  Feed({
    this.status,
    this.code,
    this.data,
  });

  int? status;
  String? code;
  List<Datum>? data;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        status: json["status"],
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.authorId,
    this.communityId,
    this.text,
    this.title,
    this.likedByUs,
    this.commentedByUs,
    this.bookmarked,
    this.timestamp,
    this.totalPostViews,
    this.isBlured,
    this.authorName,
    this.authorAvatarExtension,
    this.authorAvatarUrl,
  });

  int? id;
  int? authorId;
  int? communityId;
  String? text;
  String? title;
  bool? likedByUs;
  bool? commentedByUs;
  bool? bookmarked;
  int? timestamp;
  int? totalPostViews;
  bool? isBlured;
  String? authorName;
  AuthorAvatarExtension? authorAvatarExtension;
  String? authorAvatarUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        authorId: json["author_id"],
        communityId: json["community_id"],
        text: json["text"],
        title: json["title"],
        likedByUs: json["liked_by_us"],
        commentedByUs: json["commented_by_us"],
        bookmarked: json["bookmarked"],
        timestamp: json["timestamp"],
        totalPostViews: json["total_post_views"],
        isBlured: json["is_blured"],
        authorName: json["author_name"],
        authorAvatarExtension:
            authorAvatarExtensionValues.map[json["author_avatar_extension"]],
        authorAvatarUrl: json["author_avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author_id": authorId,
        "community_id": communityId,
        "text": text,
        "title": title,
        "liked_by_us": likedByUs,
        "commented_by_us": commentedByUs,
        "bookmarked": bookmarked,
        "timestamp": timestamp,
        "total_post_views": totalPostViews,
        "is_blured": isBlured,
        "author_name": authorName,
        "author_avatar_extension":
            authorAvatarExtensionValues.reverse![authorAvatarExtension],
        "author_avatar_url": authorAvatarUrl,
      };
}

enum AuthorAvatarExtension { PNG }

final authorAvatarExtensionValues =
    EnumValues({"png": AuthorAvatarExtension.PNG});

enum AuthorName { DAVE_RUBIN, EVGENII_KRASNOV }

final authorNameValues = EnumValues({
  "Dave Rubin": AuthorName.DAVE_RUBIN,
  "Evgenii Krasnov": AuthorName.EVGENII_KRASNOV
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
