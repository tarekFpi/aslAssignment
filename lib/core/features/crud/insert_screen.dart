
import 'package:assignment_asl/core/features/crud/crud_controller.dart';
import 'package:assignment_asl/core/features/crud/fetch_screen.dart';
import 'package:assignment_asl/core/features/crud/model/fatch_response.dart';
import 'package:assignment_asl/core/features/crud/update_screen.dart';
import 'package:assignment_asl/core/features/theme/color_scheme.dart';
import 'package:assignment_asl/core/features/utils/hexcolor.dart';
import 'package:assignment_asl/core/features/utils/toast.dart';
import 'package:assignment_asl/core/features/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';


class InsertScreen extends StatefulWidget {
  const InsertScreen({Key? key}) : super(key: key);

  @override
  State<InsertScreen> createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {

  bool obscureText = true;

  final formKey = GlobalKey<FormState>();

  final crudController = Get.put(CrudController());




  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){

        Get.to(FetchScreen());

      },  label: Text('Show'),
          icon: Icon(Icons.data_thresholding),),
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 5,
        centerTitle: true,
        title: Text("Insert page"),
      ),

      body: SingleChildScrollView(
        child: Obx(
           () {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  Align(
                      alignment: Alignment.center,
                      child: Lottie.asset("assets/animation/login.json", height: 150)),


                  Text(
                    "Insert Task",
                    style: textTheme.titleMedium?.copyWith(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Card(
                          child: TextFormField(
                           controller: crudController.titleController.value,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Your title';
                              }
                              return null;
                            }, onChanged: (value) {

                          },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.white38,
                                filled: true,
                                hintText: "Enter title",
                                prefixIcon: Icon(FluentIcons.task_list_add_20_filled,color: Colors.black38)
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Card(
                          child: TextFormField(
                            controller: crudController.bodyController.value,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Your body';
                              }
                              return null;
                            }, onChanged: (value) {

                          },
                            decoration: InputDecoration(
                              fillColor: Colors.white38,
                              filled: true,
                              contentPadding: const EdgeInsets.all(32),
                              hintText: "Enter  details",
                              prefixIcon: Icon(Icons.task,color: HexColor('#855EA9'),),
                            ),
                            keyboardType: TextInputType.text,

                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        crudController.insertLoading.value?CircularProgressIndicator():
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              //foregroundColor: colorScheme.onPrimary,
                              backgroundColor:HexColor('#855EA9'),

                            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                            onPressed: (){

                              if (formKey.currentState!.validate()) {

                                if(crudController.titleController.value.text==""){

                                  Toast.errorToast("Title is empty!!");

                                }else if(crudController.bodyController.value.text==""){
                                  Toast.errorToast("body is empty!!");
                                }else{

                                  crudController.insert();
                                }




                              }
                            },
                            child: Text('insert',style: textTheme.bodyLarge?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: lightColorScheme!.onPrimary)),
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            );
          }
        ),
      ),
    );


  }
}