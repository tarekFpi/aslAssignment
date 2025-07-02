
import 'dart:async';
import 'package:assignment_asl/core/features/crud/model/fatch_response.dart';
import 'package:assignment_asl/core/features/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class CrudController extends GetxController with StateMixin<List<FetchResponse>>{

  final tasklist = <FetchResponse>[].obs;


  final databaseRef = FirebaseDatabase.instance.ref('TaskList');


  Rx<TextEditingController> titleController = TextEditingController().obs;

  Rx<TextEditingController> bodyController = TextEditingController().obs;

  RxBool insertLoading = false.obs;

  Future insert() async {

    insertLoading(true);
    try{

      databaseRef.child(DateTime.now().microsecondsSinceEpoch.toString()).set({
        "title":titleController.value.text,
        "body":bodyController.value.text,
      }).then((value) {

        Toast.successToast("Insert SuccessFull..");

        titleController.value.clear();
        bodyController.value.clear();
        insertLoading(false);

      }).onError((error, stackTrace) {

        Toast.errorToast("Insert Failed..$error");
        insertLoading(false);
        debugPrint("Insert Failed..$error");
      });

    }catch(e){
      insertLoading(false);
      Toast.errorToast(e.toString());
    }
  }


  RxBool updateLoading = false.obs;

  Future updateTask(String title,String details,String date,String time,String id) async {

    try{
      updateLoading(true);

      databaseRef.child(id).update({
        "title":title,
        "body":details,
      }).then((value){

        Toast.successToast("Update SuccessFull..");

      //  showNotificationAndroid("Update SuccessFull..", title);

        updateLoading(false);
      }).onError((error, stackTrace) {

        updateLoading(false);

        Toast.errorToast("Update Failed..$error");
        EasyLoading.dismiss();
        debugPrint("$error");
      });

    }catch(e){
      EasyLoading.dismiss();
      Toast.errorToast(e.toString());
    }
  }

  RxBool deleteLoading = false.obs;

  Future<void> delete(String id) async {

    try{

      deleteLoading(true);
      FirebaseDatabase.instance.ref().child("TaskList").child(id).remove().then((value) {

        Toast.successToast("Delete SuccessFull..");

      //  showNotificationAndroid("Delete SuccessFull..", "SuccessFull");

        fetchTask();
        deleteLoading(false);

      },).onError((error, stackTrace) {
        deleteLoading(false);
        Toast.successToast("$error");

      });

    }catch(e){

      Toast.errorToast(e.toString());
    }
  }


  Future fetchTask() async {


    change(null, status: RxStatus.loading());

    try{

      FirebaseDatabase.instance.ref().child("TaskList").onValue.listen((needsSnapshot) {

        tasklist.clear();
        needsSnapshot.snapshot.children.forEach((element) {

          var data = FetchResponse.fromSnapshot(element);
          tasklist.add(data);
        });

        if(tasklist.isEmpty || tasklist.isNull){
          change(null, status: RxStatus.success());
        }
       change(tasklist, status: RxStatus.success());



      });


    }catch(e){

      Toast.errorToast(e.toString());

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void filterTask(String? query) {

    change(null, status: RxStatus.loading());

    if (query == null || query.isEmpty) {

      change(tasklist.value, status: RxStatus.success());

    }else{

      try{

        final list = tasklist.value
            .where((element) =>
            element.title!
                .toLowerCase()
                .contains(query!.toLowerCase().trim())
        ).toList();



        if(list.isEmpty){

          change([], status: RxStatus.empty());

        }else {
          change(list, status: RxStatus.success());
        }

      }catch(e){

        debugPrint(e.toString());
      }
    }

  }



}