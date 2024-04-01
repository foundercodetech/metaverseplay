import 'dart:convert';

import 'package:metaverseplay/generated/assets.dart';
import 'package:metaverseplay/model/user_model.dart';
import 'package:metaverseplay/res/aap_colors.dart';
import 'package:metaverseplay/res/api_urls.dart';
import 'package:metaverseplay/res/components/app_bar.dart';
import 'package:metaverseplay/res/components/app_btn.dart';
import 'package:metaverseplay/res/components/text_field.dart';
import 'package:metaverseplay/res/components/text_widget.dart';
import 'package:metaverseplay/res/provider/user_view_provider.dart';
import 'package:metaverseplay/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {


  bool hideSetPassword = true;
  bool hideConfirmPassword = true;
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController oldPassCon = TextEditingController();
  TextEditingController newPassCon = TextEditingController();
  TextEditingController confirmPassCon = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final widths = MediaQuery.of(context).size.width;
    final heights = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: AppColors.scaffolddark,
        appBar: GradientAppBar(
          leading: AppBackBtn(),
          title: textWidget(
              text: 'Change Password',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: heights*0.01,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.iconsPassword,
                            height: 30,
                            color: AppColors.goldencolortwo,
                          ),
                          const SizedBox(width: 20),
                          textWidget(
                              text: 'Login Password',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.primaryTextColor)
                        ],
                      ),
                    ),
                    SizedBox(height: heights*0.01,),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: CustomTextField(
                          obscureText: hideSetPassword,
                          controller: oldPassCon,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                          hintText: 'Enter your old password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hideSetPassword = !hideSetPassword;
                                });
                              },
                              icon: SvgPicture.asset(hideSetPassword
                                  ? Assets.iconsEyeClose
                                  : Assets.iconsEyeOpen,color: AppColors.goldencolortwo,)),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.iconsPassword,
                            height: 30,
                            color: AppColors.goldencolortwo,
                          ),
                          const SizedBox(width: 20),
                          textWidget(
                              text: 'New Password',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.primaryTextColor)
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: CustomTextField(
                          obscureText: hideSetPassword,
                          controller: newPassCon,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                          hintText: 'Please enter the new password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hideSetPassword = !hideSetPassword;
                                });
                              },
                              icon: SvgPicture.asset(hideSetPassword
                                  ? Assets.iconsEyeClose
                                  : Assets.iconsEyeOpen,color: AppColors.goldencolortwo,)),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.iconsPassword,
                            height: 30,
                            color: AppColors.goldencolortwo,
                          ),
                          const SizedBox(width: 20),
                          textWidget(
                              text: 'Confirm Password',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.primaryTextColor)
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: CustomTextField(
                          obscureText: hideSetPassword,
                          controller: confirmPassCon,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                          hintText: 'Please re-enterpassword',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hideSetPassword = !hideSetPassword;
                                });
                              },
                              icon: SvgPicture.asset(hideSetPassword
                                  ? Assets.iconsEyeClose
                                  : Assets.iconsEyeOpen,color: AppColors.goldencolortwo,)),
                        )),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                      child: AppBtn(
                        title: 'U p d a t e',
                        fontSize: 20,
                        titleColor: AppColors.browntextprimary,
                        hideBorder: true,
                        onTap: () {
                          Changepass(oldPassCon.text,newPassCon.text,confirmPassCon.text);
                        },
                        gradient: AppColors.goldenGradientDir,
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
  UserViewProvider userProvider = UserViewProvider();

  Changepass(String oldpass, String newpass,String confirmpass) async {
    if (kDebugMode) {
      print("guycyg");
    }
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print(token);
    }
    final response = await http.post(Uri.parse(ApiUrl.changepasswordapi),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic >{
          "userid":token,
          "old_password":oldpass,
          "new_password":newpass,
          "confirm_password":confirmpass
        })
    );
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
        print("👍👍👍👍updatee");
      }
      if(data["status"]=="200"){
        Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);

      }
      else {
        Utils.flushBarErrorMessage(data["msg"], context, Colors.white);
      }
    }
    else{
      throw Exception("error");
    }

  }









}
