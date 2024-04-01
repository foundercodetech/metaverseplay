// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, depend_on_referenced_packages, use_build_context_synchronously
import 'dart:convert';
import 'package:metaverseplay/generated/assets.dart';
import 'package:metaverseplay/model/addaccount_view_model.dart';
import 'package:metaverseplay/model/deposit_model_new.dart';
import 'package:metaverseplay/model/user_model.dart';
import 'package:metaverseplay/res/aap_colors.dart';
import 'package:metaverseplay/res/components/app_bar.dart';
import 'package:metaverseplay/res/components/app_btn.dart';
import 'package:metaverseplay/res/components/audio.dart';
import 'package:metaverseplay/res/components/text_field.dart';
import 'package:metaverseplay/res/components/text_widget.dart';
import 'package:metaverseplay/res/helper/api_helper.dart';
import 'package:metaverseplay/res/provider/user_view_provider.dart';
import 'package:metaverseplay/res/provider/wallet_provider.dart';
import 'package:metaverseplay/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../res/api_urls.dart';
import 'package:http/http.dart' as http;

class GridChange{
  String title;
  String images;
  GridChange(this.title,this.images);
}

class DepositScreen extends StatefulWidget {
  final AddacountViewModel? account;
  const DepositScreen({super.key, this.account});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {

 bool loading = false;
 // bool get loading => _loading;
 // setLoading(bool value) {
 //   _loading = value;
 // }

  @override
  void initState() {
    Audio.depositmusic();
    getwaySelect();
    walletfetch();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Audio.audioPlayers;
    // TODO: implement dispose
    super.dispose();
  }


  int selectedIndex = 0;
  int result = 0;

  TextEditingController depositCon = TextEditingController();
  String selectedDeposit = '';
  List<DepositModel> depositList = [
    DepositModel(value: '100', title: '100'),
    DepositModel(value: '500', title: '500'),
    DepositModel(value: '1000', title: '1K'),
    DepositModel(value: '10000', title: '10K'),
    DepositModel(value: '50000', title: '50K'),
    DepositModel(value: '100000', title: '100K'),
  ];

  List<GridChange> list = [
    // GridChange("Local UPI Bonus",Assets.imagesUpiImage),
    GridChange("Fast Pay",Assets.imagesFastpayImage),
    GridChange("USDT",Assets.imagesUsdtIcon),

  ];


  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    int ?responseStatuscode;


    final walletdetails = Provider.of<WalletProvider>(context).walletlist;

    // final coins = Provider.of<CoinProvider>(context).CoinData;

    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;



    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Audio.audioPlayers.stop();
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(Assets.iconsArrowBack)),
          ),
          title: textWidget(
              text: 'Deposit', fontSize: 25, color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body:
      walletdetails!= null?
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: heights * 0.21,
                width: widths,
                padding: const EdgeInsets.all(15),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(Assets.imagesCardImage),
                        fit: BoxFit.fill
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Assets.iconsDepoWallet, height: 30),
                            const SizedBox(width: 15),
                            textWidget(
                                text: 'Balance',
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 15),
                            const Icon(Icons.currency_rupee,
                            ),
                            textWidget(
                              text: walletdetails.wallet.toString(),
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                            const SizedBox(width: 15),
                            InkWell(
                                onTap: (){
                                  paymentstatus(userstatus);
                                  walletfetch();
                                },
                                child: SvgPicture.asset(Assets.iconsTotalBal, height: 30, )),
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset(Assets.iconsChip),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              responseStatuscode== 400 ?
              const Notfounddata(): items.isEmpty? Container():
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final currentId = int.parse(items[index].id.toString());

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = currentId;
                        print(selectedIndex);
                        print('rrrrrrrrrrrrrrrrr');
                        print(currentId);
                        print('yyyyyyyyyyyyy');
                      });
                      Audio.audioPlayers.play();

                    },
                    child: Card(
                      elevation: selectedIndex == currentId ? 2 : 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: selectedIndex == currentId
                              ? AppColors.goldenGradientDir
                              : AppColors.secondaryappbar,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            items[index].image != null
                                ? Image.network(items[index].image.toString(), height: 45,)
                                : const Placeholder(
                              fallbackHeight: 45,
                            ),
                            textWidget(
                                text: items[index].name.toString(),
                                fontSize: 13,
                                color: selectedIndex == currentId
                                    ? AppColors.browntextprimary
                                    : AppColors.browntextprimary,
                                fontWeight: FontWeight.w900
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20,),
              // selectedIndex != -1
              //     ? containers[selectedIndex]
              //     : Container(),

              const SizedBox(height: 20),

              selectedIndex == 0?Container():
              Container(
                height: heights * 0.20,
                width: widths,
                padding:  EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    gradient: AppColors.secondaryappbar,
                    borderRadius: BorderRadiusDirectional.circular(15)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(Assets.iconsSaveWallet,height: heights*0.05,),
                        const SizedBox(width: 15),
                        textWidget(
                            text: 'Deposit amount',
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.goldencolorthree
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      fillColor: AppColors.scaffolddark,
                      hintText: 'Please enter the amount',
                      fieldRadius: BorderRadius.circular(30),
                      textColor: Colors.white,
                      keyboardType: TextInputType.number,
                      fontWeight: FontWeight.w600,
                      controller: depositCon,
                      onChanged: (value) {
                      },
                      prefixIcon: SizedBox(
                        width: 70,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Icon(Icons.currency_rupee,
                                color: AppColors.goldencolorthree),
                            const SizedBox(width: 10),
                            Container(height: 30, color: Colors.white, width: 2)
                          ],
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            depositCon.clear();
                            selectedDeposit = '';
                          });
                        },
                        icon: const Icon(Icons.cancel_outlined,
                            color: AppColors.iconColor),
                      ),
                    ),


                  ],
                ),
              ),

              const SizedBox(height: 20),

              selectedIndex == 0 && depositCon.text.isEmpty
                  ? Container()
                  : loading==false?
              AppBtn(
                onTap: () {
                  //_launchURL1();
                  addmony(depositCon.text);
                },
                hideBorder: true,
                title: 'Deposit',
                gradient: AppColors.primaryappbargrey,
              ):Center(
                child: Container(
                  height: 45,
                  width: 43,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.gradientFirstColor,
                          AppColors.gradientSecondColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: const EdgeInsets.all(12),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4,
                  ),
                ),
              ),



              const SizedBox(height: 20),
              Container(
                width: widths,
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    gradient: AppColors.goldenGradientDir,
                    borderRadius: BorderRadiusDirectional.circular(15)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Assets.iconsRecIns),
                        const SizedBox(width: 15),
                        textWidget(
                            text: 'Recharge instructions',
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ],
                    ),
                    instruction('If the transfer time is up, please fill out the deposit form again.'),
                    instruction('The transfer amount must match the order you created, otherwise the money cannot be credited successfully.'),
                    instruction('If you transfer the wrong amount, our company will not be responsible for the lost amount!'),
                    instruction('Note: do not cancel the deposit order after the money has been transferred.'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      )
          :Container(),

    );


  }



  Future<void> walletfetch() async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final wallet_data = await baseApiHelper.fetchWalletData();
      if (kDebugMode) {
        print(wallet_data);
        print("wallet_data");
      }
      Provider.of<WalletProvider>(context, listen: false).setWalletList(wallet_data!);
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }
int minimumamount=100;
  ///getway api
  List<GetwayModel> items = [];

  Future<void> getwaySelect() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.getwayList+token),);
    print(ApiUrl.getwayList+token);
    print('getwayList+token');


    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        minimumamount=json.decode(response.body)['minimum'];

        items = responseData.map((item) => GetwayModel.fromJson(item)).toList();
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
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }



  UserViewProvider userProvider = UserViewProvider();


  String userstatus="";

  addmony(String depositCon)async {
    setState(() {
      loading=true;
    });
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    print(ApiUrl.deposit);
    print("ApiUrl.deposit");

    final response =  await http.post(Uri.parse(ApiUrl.deposit),

      headers:<String ,String>{
        "Content-Type":"application/json; charset=UTF-8",
      },
      body: jsonEncode(<String ,String>{
        "userid":token,
        "amount": depositCon,
        "type":selectedIndex.toString()
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    print("jdguywfud");
    if(data["status"]=='SUCCESS'){
      setState(() {
        loading=false;
      });

      var urlget =data['upi_deep_link'].toString();
       userstatus =data['user_trans_id_status'].toString();

      _launchURL(urlget);
     // Navigator.push(context,MaterialPageRoute(builder: (context)=>payment_Web(url: url,)));
      Utils.flushBarSuccessMessage(data["msg"],context, Colors.white);
    }
    else{
      setState(() {
        loading=false;
      });
      Utils.flushBarErrorMessage( data["msg"],context, Colors.white);
    }

  }


  _launchURL(String urlget) async {
    var url = urlget;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


 paymentstatus(String userstatus)async {

   print(ApiUrl.paymentCheckStatus+userstatus);
   print("ApiUrl.paymentCheckStatus+userstatus");

   final response =  await http.get(Uri.parse(ApiUrl.paymentCheckStatus+userstatus),

   );
   final data = jsonDecode(response.body);
   print(data);
   print("jdguywfud");
   if(data["status"]=="200"){
     Utils.flushBarSuccessMessage( data["msg"],context, Colors.white);
   }
   else{
     Utils.flushBarErrorMessage( data["msg"],context, Colors.white);
   }
 }
}


class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
    final heights = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: heights*0.07),
        const Text("Data not found",)
      ],
    );
  }

}

Widget instruction(String title){
  return ListTile(
    leading: Transform.rotate(
      angle: 45 * 3.1415927 / 180,
      child: Container(
        height: 10,
        width: 10,
        color: AppColors.gradientFirstColor,
      ),
    ),
    title: textWidget(
      text:
      title,
      fontSize: 14,

    ),
  );
}

class DepositModel {
  final String value;
  final String title;

  DepositModel({
    required this.value,
    required this.title,
  });
}
