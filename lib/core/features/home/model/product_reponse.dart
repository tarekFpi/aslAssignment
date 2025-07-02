// To parse this JSON data, do
//
//     final productReponseModel = productReponseModelFromJson(jsonString);

import 'dart:convert';

List<ProductReponseModel> productReponseModelFromJson(String str) => List<ProductReponseModel>.from(json.decode(str).map((x) => ProductReponseModel.fromJson(x)));

String productReponseModelToJson(List<ProductReponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductReponseModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  ProductReponseModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory ProductReponseModel.fromJson(Map<String, dynamic> json) => ProductReponseModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
