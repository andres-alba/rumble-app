// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    Login({
        this.result,
    });

    Result? result;

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result!.toJson(),
    };
}

class Result {
    Result({
        this.username,
        this.email,
        this.userId,
        this.uniqueId,
        this.ssAuthToken,
        this.activeSubscriber,
        this.unclaimedGift,
    });

    String? username;
    String? email;
    int? userId;
    String? uniqueId;
    String? ssAuthToken;
    int? activeSubscriber;
    int? unclaimedGift;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        username: json["username"],
        email: json["email"],
        userId: json["user_id"],
        uniqueId: json["unique_id"],
        ssAuthToken: json["ss_auth_token"],
        activeSubscriber: json["active_subscriber"],
        unclaimedGift: json["unclaimed_gift"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "user_id": userId,
        "unique_id": uniqueId,
        "ss_auth_token": ssAuthToken,
        "active_subscriber": activeSubscriber,
        "unclaimed_gift": unclaimedGift,
    };
}
