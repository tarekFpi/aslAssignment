
import 'package:firebase_database/firebase_database.dart';


class FetchResponse {

  String? id;
  String? title;
  String? body;


  FetchResponse({
    this.id,
    this.title,
    this.body,

  });

  FetchResponse.fromSnapshot(DataSnapshot snapshot){
    Map<String, dynamic> myData= Map<String,dynamic>.from(snapshot.value as
    Map);
    id= snapshot.key.toString();
    title = myData["title"].toString() ?? '';
    body =myData["body"].toString() ?? '';
  }



  Map<String,dynamic> toJson() {
    return {
      "title": title,
      "body": body,
    };
  }
}

