import 'package:assignment_asl/core/features/crud/crud_controller.dart';
import 'package:assignment_asl/core/features/crud/model/fatch_response.dart';
import 'package:assignment_asl/core/features/crud/update_screen.dart';
import 'package:assignment_asl/core/features/theme/color_scheme.dart';
import 'package:assignment_asl/core/features/utils/hexcolor.dart';
import 'package:assignment_asl/core/features/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {

  final crudController = Get.put(CrudController());

  final queryEditingController = TextEditingController();

  String query = "";

  void goToDelete(FetchResponse item){

    FocusScope.of(context).unfocus();

    crudController.delete(item.id.toString());
  }

  void goToUpdatePage(FetchResponse item){

    FocusScope.of(context).unfocus();

    Get.to(() => UpdateScreen(
      tasklist: item,
    ));
  }

  @override
  void initState() {

    crudController.fetchTask();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(child: Scaffold(
      appBar:AppBar(
          elevation: 2,
          centerTitle: true,
          title: Text(
            "Fetch Firebase",
            style: textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )),

      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [

            Card(
              child: TextFormField(
                controller: queryEditingController,
                decoration: InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    hintText: "Search...for..title",
                    prefixIcon: Icon(
                      Icons.search,
                      color: HexColor('#855EA9'),
                    ),

                    hintStyle: textTheme.bodyMedium
                        ?.copyWith(color: HexColor("#BCC2EB")),
                    suffixIcon: query.isBlank == true || query.isEmpty
                        ? Icon(
                      FluentIcons.search_24_regular,
                      color: HexColor("#BCC2EB"),
                    )
                        : IconButton(
                        icon: Icon(Icons.close, color: HexColor("#BCC2EB")),
                        onPressed: () {
                          //clear query
                          setState(() {
                            query = "";
                          });
                          queryEditingController.clear();
                          FocusScope.of(context).unfocus();
                          crudController.filterTask(null);
                        })

                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                  crudController.filterTask(value);
                },
              ),
            ),

            crudController.tasklist.isEmpty?
            SizedBox(
              height: MediaQuery.of(context).size.height/4,
              child: Center(
                child: Text(
                  "No event yet!!",
                 style: TextStyle(
                   fontSize: 24,
                   color: Colors.red
                 ),
                ),
              ),
            ):
            Expanded(
              child: crudController.obx((state) =>  RefreshIndicator(
                onRefresh:crudController.fetchTask,
                child:
                ListView.builder(
                    itemCount: state?.length,
                    itemBuilder: (BuildContext context,index){

                      final item = state?[index];

                      return Card(
                        color:  HexColor("#FAFDFC"),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    "title : ${item?.title}",
                                    style: textTheme.bodySmall?.copyWith(
                                        color: lightColorScheme.onTertiaryContainer,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  Row(
                                    children: [

                                      InkWell(
                                        onTap: (){

                                          goToUpdatePage(item!);
                                        },
                                        child: const CircleAvatar(
                                          radius: 16.0,
                                          backgroundColor: Colors.grey,
                                          child: Icon(FluentIcons.edit_12_filled,),
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 16,
                                      ),

                                      InkWell(
                                        onTap: (){
                                          goToDelete(item!);
                                        },
                                        child: const CircleAvatar(
                                          radius: 16.0,
                                          backgroundColor: Colors.grey,
                                          child: Icon(FluentIcons.delete_12_filled,),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "body :${item?.body}",
                                style: textTheme.bodySmall?.copyWith(
                                    color: lightColorScheme.onTertiaryContainer,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),

                            ],
                          ),
                        ),
                      );
                    }),

              ),onError: (msg) {
                return CustomErrorWidget(
                    icon: Icon(
                      msg == "No Internet." ? FluentIcons.wifi_off_24_regular : FluentIcons.error_circle_24_filled,
                      color: Colors.red,
                      size: 40,
                    ),
                    btnLevel: "Retry",
                    message: msg.toString(),
                    onClick: () {
                      crudController.fetchTask;
                    });
              },),
            ),

          ],
        ),
      ),
    ));
  }
}

