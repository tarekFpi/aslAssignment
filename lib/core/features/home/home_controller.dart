
import 'package:assignment_asl/core/features/home/model/product_reponse.dart';
import 'package:assignment_asl/core/features/network/dio_client.dart';
import 'package:assignment_asl/core/features/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<List<ProductReponseModel>> {

  final dioClient = DioClient.instance;

  final Rx<TextEditingController> queryEditingController =
      TextEditingController().obs;

  RxString query = "".obs;

  final productList = <ProductReponseModel>[].obs;

  RxBool productShowListLoading = false.obs;

  Future<void> showProductList() async{

    productShowListLoading(true);

    change(null, status: RxStatus.loading());

    try {

      final response = await dioClient.get("/posts");

      if(response !=null){

        response.forEach((element) {
          var game = ProductReponseModel.fromJson(element);
          productList.add(game);
        });

        if (productList.isEmpty) {
          change(null, status: RxStatus.empty());
          productShowListLoading(false);
        } else {

          change(productList, status: RxStatus.success());
          productShowListLoading(false);

        }

      }else {
        productShowListLoading(false);
        Toast.errorToast("data not found");

      }

    } catch(e) {
      productShowListLoading(false);
      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }


  void filterProduct(String? query) {

    if (query == null || query.isEmpty) {

      change(productList.value, status: RxStatus.success());

    }else{

      try {

        final list = productList.value
            .where((element) =>
            element.title!
                .toLowerCase()
                .contains(query!.toLowerCase().trim()))
            .toList();

        if (list.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(list, status: RxStatus.success());
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    showProductList();
  }

}