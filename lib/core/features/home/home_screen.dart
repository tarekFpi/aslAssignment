
import 'package:assignment_asl/core/features/auth/auth_controller.dart';
import 'package:assignment_asl/core/features/auth/login_screen.dart';
import 'package:assignment_asl/core/features/crud/insert_screen.dart';
import 'package:assignment_asl/core/features/home/home_controller.dart';
import 'package:assignment_asl/core/features/home/model/product_reponse.dart';
import 'package:assignment_asl/core/features/home/product_details_screen.dart';
import 'package:assignment_asl/core/features/utils/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final homeController = Get.put(HomeController());

  final storage = GetStorage();

  final authController = Get.put(AuthController());

  void goToDetails(ProductReponseModel taskResponse){

    FocusScope.of(context).unfocus();

    Get.to(() => ProductDetailsScreen(
      tasklist: taskResponse,
    ));

  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        Get.to(InsertScreen());

      },child: Icon(Icons.add),),
      appBar: AppBar(
         backgroundColor: Colors.white12,
        elevation: 5,
        centerTitle: true,
        title: Text("Home page"),
        actions: [
         IconButton(onPressed: (){
           authController.signOut();
           Get.offAll(LoginScreen());
         }, icon: Icon(Icons.login))
        ],

      ),
      body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Obx(
                  () {
                return Column(
                  children: [
                    // Search Bar
                  TextFormField(
                  controller:homeController.queryEditingController.value,
                  decoration: InputDecoration(
                      fillColor: Colors.white38,
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                      hintText: "Search...For..title",
                      prefixIcon: Icon(
                        Icons.search,
                        color: HexColor('#855EA9'),
                      ),
                      hintStyle: textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey),
                      suffixIcon:homeController.query.value.isBlank == true || homeController.query.value.isEmpty
                          ? Icon(
                        FluentIcons.search_24_regular,
                        color: HexColor("#BCC2EB"),
                      )
                          : IconButton(
                          icon: Icon(Icons.close, color: HexColor("#BCC2EB")),
                          onPressed: () {
                            //clear query

                            homeController.query.value = "";

                            homeController.queryEditingController.value.clear();
                            FocusScope.of(context).unfocus();
                            homeController.filterProduct(null);
                          })

                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {

                    homeController.query.value = value;

                    homeController.filterProduct(value);
                  },
                ),
                    const SizedBox(height: 16),

                    // Products Grid
                    homeController.obx((state){

                      return Expanded(
                        child: ListView.builder(
                            itemCount: state!.length,
                            itemBuilder: (context, index) {
                              final item = state![index];
                              return SizedBox(
                                height: 160,
                                child: Card(
                                  elevation: 0.5,
                                  margin: EdgeInsets.all(12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      goToDetails(item);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${item.title}",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );

                    }),

                  ],
                );
              }
          )
      ),
    );
  }
}
