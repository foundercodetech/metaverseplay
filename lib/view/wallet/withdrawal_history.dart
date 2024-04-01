// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';
import 'package:metaverseplay/generated/assets.dart';
import 'package:metaverseplay/model/user_model.dart';
import 'package:metaverseplay/model/withdrawhistory_model.dart';
import 'package:metaverseplay/res/aap_colors.dart';
import 'package:metaverseplay/res/api_urls.dart';
import 'package:metaverseplay/res/components/app_bar.dart';
import 'package:metaverseplay/res/components/app_btn.dart';
import 'package:metaverseplay/res/components/text_widget.dart';
import 'package:metaverseplay/res/helper/api_helper.dart';
import 'package:metaverseplay/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class WithdrawHistory extends StatefulWidget {
  const WithdrawHistory({super.key});

  @override
  State<WithdrawHistory> createState() => _WithdrawHistoryState();
}

class _WithdrawHistoryState extends State<WithdrawHistory> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    WithdrawHistoryyy();
    super.initState();

  }

  late int selectedCatIndex;

  int ?responseStatuscode;


  List<History> historylist = [
    History("Processing", "₹100.00", "7Days - App", "P202389678"),
    History("Complete", "₹100.00", "7Days - App", "P202389678"),
    History("Processing", "₹100.00", "7Days - App", "P202389678"),
    History("Complete", "₹100.00", "7Days - App", "P202389678"),
  ];

  BaseApiHelper baseApiHelper = BaseApiHelper();


  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
          title: textWidget(
              text: 'Withdraw History',
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
            const Notfounddata(): WithdrawItems.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: WithdrawItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        color: Color(0xFF3f3f3f),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: widths * 0.30,
                                      decoration: BoxDecoration(
                                          color: WithdrawItems[index].status=="0"?Colors.orange: WithdrawItems[index].status=="1"?AppColors.DepositButton:Colors.red,
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: textWidget(
                                          text: WithdrawItems[index].status=="0"?"Pending":WithdrawItems[index].status=="1"?"Complete":"Failed",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryTextColor
                                      ),
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
                                      color: AppColors.secondaryTextColor),
                                  textWidget(
                                      text: "₹"+WithdrawItems[index].amount.toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
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
                                      text: "Account No.",
                                      fontSize: widths * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                  textWidget(
                                      text: WithdrawItems[index].accountno.toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
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
                                      color: AppColors.secondaryTextColor),

                                  Text(DateFormat("dd-MMM-yyyy, hh:mm a").format(
                                      DateTime.parse(WithdrawItems[index].date.toString())),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,),),
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

  List<WithdrawModel> WithdrawItems = [];

  Future<void> WithdrawHistoryyy() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.withdrawHistory+token),);
    if (kDebugMode) {
      print(ApiUrl.withdrawHistory+token);
      print('withdrawHistory');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        WithdrawItems = responseData.map((item) => WithdrawModel.fromJson(item)).toList();
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
        WithdrawItems = [];
      });
      throw Exception('Failed to load data');
    }
  }

}

class BetIconModel {
  final String title;
  final String? image;
  BetIconModel({required this.title, this.image});
}

class History{
  String method;
  String balance;
  String type;
  String orderno;
  History(this.method,this.balance,this.type,this.orderno);
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
        SizedBox(height: heights*0.05,),
        Image.asset(Assets.imagesNoDataAvailable,height: heights*0.21,),
        const Text("No data (:",style: TextStyle(color: Colors.white),)
      ],
    );
  }

}
