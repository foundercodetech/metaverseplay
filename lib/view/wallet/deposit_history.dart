// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';
import 'package:metaverseplay/generated/assets.dart';
import 'package:metaverseplay/model/user_model.dart';
import 'package:metaverseplay/res/aap_colors.dart';
import 'package:metaverseplay/res/api_urls.dart';
import 'package:metaverseplay/res/components/app_bar.dart';
import 'package:metaverseplay/res/components/app_btn.dart';
import 'package:metaverseplay/res/components/text_widget.dart';
import 'package:metaverseplay/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../model/deposit_model.dart';

class History {
  String method;
  String balance;
  String type;
  String orderno;
  History(this.method, this.balance, this.type, this.orderno);
}

class DepositHistory extends StatefulWidget {
  const DepositHistory({super.key});

  @override
  State<DepositHistory> createState() => _DepositHistoryState();
}

class _DepositHistoryState extends State<DepositHistory> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    DepositHistoryyy();
    super.initState();

  }

  int ?responseStatuscode;


  @override
  Widget build(BuildContext context) {

    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
          title: textWidget(
              text: 'Deposit History',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            responseStatuscode== 400 ?
            const Notfounddata(): DepositItems.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                      itemCount: DepositItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          color: const Color(0xFF3f3f3f),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: widths * 0.30,
                                      decoration: BoxDecoration(
                                          color: DepositItems[index].status=="0"?Colors.orange: DepositItems[index].status=="1"?AppColors.DepositButton:Colors.red,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: textWidget(
                                          text: DepositItems[index].status=="0"?"Pending":DepositItems[index].status=="1"?"Complete":"Failed",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryTextColor
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Balance",
                                        fontSize: widths * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    textWidget(
                                        text: "₹${DepositItems[index].amount}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:  const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Type",
                                        fontSize: widths * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    Image.asset(DepositItems[index].type=="2"?Assets.imagesUsdtIcon:Assets.imagesFastpayImage, height: heights*0.05,)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Time",
                                        fontSize: widths * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    textWidget(
                                        text: DateFormat("dd-MMM-yyyy, hh:mm a").format(DateTime.parse(DepositItems[index].created_at.toString())),                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryTextColor

                                        ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Order number",
                                        fontSize: widths * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    Row(
                                      children: [
                                        textWidget(
                                            text: DepositItems[index].orderid.toString(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.primaryTextColor),
                                        SizedBox(
                                          width: widths * 0.01,
                                        ),
                                        Image.asset(Assets.iconsCopy, color: Colors.grey,height: heights * 0.03)                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      })

            ),

          ],
        ),
      ),

    );
  }

  UserViewProvider userProvider = UserViewProvider();

  List<DepositModel> DepositItems = [];

  Future<void> DepositHistoryyy() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.depositHistory+token),);
    if (kDebugMode) {
      print(ApiUrl.depositHistory);
      print('depositHistory');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        DepositItems = responseData.map((item) => DepositModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        DepositItems = [];
      });
      throw Exception('Failed to load data');
    }
  }

}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: heights / 3,
          width: widths / 2,
        ),
        const Text("Data not found",)
      ],
    );
  }

}



