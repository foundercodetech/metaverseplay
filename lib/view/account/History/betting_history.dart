// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:metaverseplay/generated/assets.dart';
import 'package:metaverseplay/model/bettingHistory_Model.dart';
import 'package:metaverseplay/model/bettinghistoryTRX.dart';
import 'package:metaverseplay/model/user_model.dart';
import 'package:metaverseplay/res/aap_colors.dart';
import 'package:metaverseplay/res/api_urls.dart';
import 'package:metaverseplay/res/components/app_bar.dart';
import 'package:metaverseplay/res/components/app_btn.dart';
import 'package:metaverseplay/res/components/clipboard.dart';
import 'package:metaverseplay/res/components/text_widget.dart';
import 'package:metaverseplay/res/provider/user_view_provider.dart';
import 'package:metaverseplay/view/account/History/AvaitorBethistory.dart';
import 'package:metaverseplay/view/home/lottery/WinGo/win_go_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class BetHistory extends StatefulWidget {
  const BetHistory({super.key});

  @override
  State<BetHistory> createState() => _BetHistoryState();
}

class _BetHistoryState extends State<BetHistory> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    BettingHistory();
    BettingHistoryTRX();
    super.initState();
    selectedCatIndex = 0;
  }

  int ?responseStatuscode;



  List<BetIconModel> betIconList = [
    BetIconModel(title: 'Lottery', image: Assets.imagesLotteryIcon),
    BetIconModel(title: 'Mini games', image: Assets.imagesCasinoIcon),
    BetIconModel(title: 'TRX', image: Assets.imagesLotteryIcon),
    // BetIconModel(title: 'Original', image: Assets.imagesOriginalIcon),
    // BetIconModel(title: 'Slots', image: Assets.imagesSlotsIcon),
  ];
  late int selectedCatIndex;



  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
        appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Bet History',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 70,
              width: widths * 0.93,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: betIconList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCatIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        height: 35,
                        width: 115,
                        decoration: BoxDecoration(
                          gradient: selectedCatIndex == index
                              ? AppColors.goldenGradientDir
                              : AppColors.secondaryappbar,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 0.1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.2,
                              blurRadius: 2,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('${betIconList[index].image}'),
                              height: 25,
                              color: selectedCatIndex == index
                                  ? AppColors.browntextprimary
                                  : AppColors.goldencolorthree,
                            ),
                            textWidget(
                              text: betIconList[index].title,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selectedCatIndex == index
                                  ? AppColors.browntextprimary
                                  : AppColors.goldencolorthree,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 5,),
            selectedCatIndex==0?
            responseStatuscode== 400 ?
            const Notfounddata(): items.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context , index){
                    List<Color> colors;

                    if (items[index].number == '0') {
                      colors = [
                        const Color(0xFFfd565c),
                        const Color(0xFFb659fe),
                      ];
                    } else if (items[index].number == '5') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFFb659fe),
                      ];
                    }  else if (items[index].number == '10') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),

                      ];
                    }  else if (items[index].number == '20') {
                      colors = [

                        const Color(0xFFb659fe),
                        const Color(0xFFb659fe),
                      ];
                    }  else if (items[index].number == '30') {
                      colors = [
                        const Color(0xFFfd565c),
                        const Color(0xFFfd565c),
                      ];
                    }  else if (items[index].number == '40') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),

                      ];
                    }  else if (items[index].number == '50') {
                      colors = [
                        //blue
                        const Color(0xFF6da7f4),
                        const Color(0xFF6da7f4)
                      ];
                    } else {
                      int number = int.parse(items[index].number.toString());
                      colors = number.isOdd
                          ? [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),
                      ]
                          : [
                        const Color(0xFFfd565c),
                        const Color(0xFFfd565c),
                      ];
                    }

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(gradient: AppColors.secondaryappbar,
                        borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 25,
                                        width: widths * 0.40,
                                        decoration:  BoxDecoration(
                                            gradient: AppColors.goldenGradientDir,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: textWidget(
                                            text: 'Bet',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.browntextprimary),
                                      ),
                                    ),
                                    textWidget(text:  items[index].status=="0"?"Pending":items[index].status=="1"?"Win":"Loss",
                                        fontSize: widths*0.05,
                                        fontWeight: FontWeight.w600,
                                        color: items[index].status=="1"?Colors.green:Colors.red

                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Balance",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor

                                    ),
                                    textWidget(text: "₹${items[index].amount}",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Bet Type",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    int.parse(items[index].number.toString())<=9?
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: widths*0.20,
                                      child: GradientTextview(
                                        items[index].number.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                        gradient: LinearGradient(
                                            colors: colors,
                                            stops: const [
                                              0.5,
                                              0.5,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            tileMode: TileMode.mirror),
                                      ),
                                    ):GradientTextview(
                                      items[index].number.toString()=='10'?'Green':items[index].number.toString()=='20'?'Voilet':items[index].number.toString()=='30'?'Red':items[index].number.toString()=='40'?'Big':items[index].number.toString()=='50'?'Small':'',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                      gradient: LinearGradient(
                                          colors: colors,
                                          stops: const [
                                            0.5,
                                            0.5,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          tileMode: TileMode.mirror),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Type",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(text: items[index].gameid=="1"?"1 min":items[index].gameid=="2"?"3 min":items[index].gameid=="4"?"5 min":"10 min",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Win Amount",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(text: items[index].win==null?'₹ 0.0':'₹ ${items[index].win}',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Time",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(
                                        text: DateFormat("dd-MMM-yyyy, hh:mm a").format(
                                            DateTime.parse(items[index].datetime.toString())),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor

                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Order number",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    Row(
                                      children: [
                                        textWidget(text: items[index].gamesno.toString(),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.primaryTextColor
                                        ),
                                        SizedBox(width: widths*0.01,),
                                        InkWell(
                                            onTap: (){
                                              copyToClipboard(items[index].gamesno.toString(),context);
                                            },
                                            child: Image.asset(Assets.iconsCopy,color: Colors.grey,height: heights*0.027,)),

                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );

                  }),
            ):
            selectedCatIndex==1?
            avaitorBetHistory():
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: itemsTRX.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context , index){
                    List<Color> colors;

                    if (itemsTRX[index].number == '0') {
                      colors = [
                        const Color(0xFFfd565c),
                        const Color(0xFFb659fe),
                      ];
                    } else if (itemsTRX[index].number == '5') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFFb659fe),
                      ];
                    }  else if (itemsTRX[index].number == '10') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),

                      ];
                    }  else if (itemsTRX[index].number == '20') {
                      colors = [

                        const Color(0xFFb659fe),
                        const Color(0xFFb659fe),
                      ];
                    }  else if (itemsTRX[index].number == '30') {
                      colors = [
                        const Color(0xFFfd565c),
                        const Color(0xFFfd565c),
                      ];
                    }  else if (itemsTRX[index].number == '40') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),

                      ];
                    }  else if (itemsTRX[index].number == '50') {
                      colors = [
                        //blue
                        const Color(0xFF6da7f4),
                        const Color(0xFF6da7f4)
                      ];
                    } else {
                      int number = int.parse(itemsTRX[index].number.toString());
                      colors = number.isOdd
                          ? [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),
                      ]
                          : [
                        const Color(0xFFfd565c),
                        const Color(0xFFfd565c),
                      ];
                    }

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(gradient: AppColors.secondaryappbar,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 25,
                                        width: widths * 0.40,
                                        decoration:  BoxDecoration(
                                            gradient: AppColors.goldenGradientDir,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: textWidget(
                                            text: 'Bet',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.browntextprimary),
                                      ),
                                    ),
                                    textWidget(text:  itemsTRX[index].status=="0"?"Pending":itemsTRX[index].status=="1"?"Win":"Loss",
                                        fontSize: widths*0.05,
                                        fontWeight: FontWeight.w600,
                                        color: itemsTRX[index].status=="1"?Colors.green:Colors.red

                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Balance",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor

                                    ),
                                    textWidget(text: "₹${itemsTRX[index].amount}",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Bet Type",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    int.parse(itemsTRX[index].number.toString())<=9?
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: widths*0.20,
                                      child: GradientTextview(
                                        itemsTRX[index].number.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                        gradient: LinearGradient(
                                            colors: colors,
                                            stops: const [
                                              0.5,
                                              0.5,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            tileMode: TileMode.mirror),
                                      ),
                                    ):GradientTextview(
                                      itemsTRX[index].number.toString()=='10'?'Green':itemsTRX[index].number.toString()=='20'?'Voilet':itemsTRX[index].number.toString()=='30'?'Red':itemsTRX[index].number.toString()=='40'?'Big':itemsTRX[index].number.toString()=='50'?'Small':'',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                      gradient: LinearGradient(
                                          colors: colors,
                                          stops: const [
                                            0.5,
                                            0.5,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          tileMode: TileMode.mirror),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Type",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(text: itemsTRX[index].gameid=="1"?"1 min":itemsTRX[index].gameid=="2"?"3 min":itemsTRX[index].gameid=="4"?"5 min":"10 min",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Win Amount",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(text: itemsTRX[index].win==null?'₹ 0.0':'₹ ${itemsTRX[index].win}',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Time",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(
                                        text: DateFormat("dd-MMM-yyyy, hh:mm a").format(
                                            DateTime.parse(itemsTRX[index].datetime.toString())),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor

                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Order number",
                                        fontSize: widths*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    Row(
                                      children: [
                                        textWidget(text: itemsTRX[index].gamesno.toString(),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.primaryTextColor
                                        ),
                                        SizedBox(width: widths*0.01,),
                                        InkWell(
                                            onTap: (){
                                              copyToClipboard(itemsTRX[index].gamesno.toString(),context);
                                            },
                                            child: Image.asset(Assets.iconsCopy,color: Colors.grey,height: heights*0.027,)),

                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );

                  }),
            )


          ],
        ),
      ),
    );
  }


  UserViewProvider userProvider = UserViewProvider();
  List<BettingHistoryModel> items = [];
  Future<void> BettingHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.betHistory+token),);
    if (kDebugMode) {
      print(ApiUrl.betHistory+token);
      print('betHistory+token');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData.map((item) => BettingHistoryModel.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }

  List<BettingHistoryModelTRX> itemsTRX = [];
  Future<void> BettingHistoryTRX() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.post(Uri.parse(ApiUrl.betHistoryTRX),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userid":token
      }),
    );
    if (kDebugMode) {
      print(ApiUrl.betHistoryTRX);
      print('betHistoryTRX');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        itemsTRX = responseData.map((item) => BettingHistoryModelTRX.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        itemsTRX = [];
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
        SizedBox(height: heights*0.07),
        const Text("Data not found",)
      ],
    );
  }

}
class GradientTextview extends StatelessWidget {
  GradientTextview(
      this.text, {
        super.key,
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
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