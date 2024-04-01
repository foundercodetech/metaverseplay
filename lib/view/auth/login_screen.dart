import 'dart:convert';
import 'package:metaverseplay/generated/assets.dart';
import 'package:metaverseplay/res/aap_colors.dart';
import 'package:metaverseplay/res/components/app_bar.dart';
import 'package:metaverseplay/res/components/app_btn.dart';
import 'package:metaverseplay/res/components/launcher.dart';
import 'package:metaverseplay/res/components/text_field.dart';
import 'package:metaverseplay/res/components/text_widget.dart';
import 'package:metaverseplay/res/provider/auth_provider.dart';
import 'package:metaverseplay/utils/routes/routes_name.dart';
import 'package:metaverseplay/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  bool selectedButton = true;
  bool hidePassword = true;
  bool rememberPass = false;
  // bool activeButton = true;
  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController passwordConn = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<UserAuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          title: SvgPicture.asset(Assets.imagesLogoredmeta,color: AppColors.goldencolor),
          leading: const AppBackBtn(),
          gradient: AppColors.primaryappbargrey),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration:
                       BoxDecoration(gradient: AppColors.primaryappbargrey),
                  child: ListTile(
                    title: textWidget(
                        text: 'Log in',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: AppColors.primaryTextColor),
                    subtitle: textWidget(
                        text: 'Please log in with your phone number or email\nIf you forget your password, please contact customer service',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.primaryTextColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedButton = !selectedButton;
                            // activeButton = !activeButton;
                          });
                        },
                        child: Column(
                          children: [
                            selectedButton
                                ? SvgPicture.asset(Assets.iconsPhoneTabColor,color: AppColors.goldencolortwo,)
                                : SvgPicture.asset(Assets.iconsPhoneTab),
                            textWidget(
                                text: 'Log in with phone',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: selectedButton
                                    ? AppColors.goldencolortwo
                                    : AppColors.secondaryTextColor)
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedButton = !selectedButton;
                            // activeButton = !activeButton;
                          });
                        },
                        child: Column(
                          children: [
                            !selectedButton
                                ? SvgPicture.asset(Assets.iconsEmailTabColor,color: AppColors.goldencolortwo)
                                : SvgPicture.asset(Assets.iconsEmailTab),
                            textWidget(
                                text: 'Email Login',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: !selectedButton
                                    ? AppColors.goldencolortwo
                                    : AppColors.secondaryTextColor)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Divider(thickness: 0.7, color: AppColors.dividerColor),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    children: [
                      SvgPicture.asset(selectedButton
                          ? Assets.iconsPhone
                          : Assets.iconsEmailTabColor,color: AppColors.goldencolortwo),
                      const SizedBox(width: 20),
                      textWidget(
                          text: selectedButton ? 'Phone Number' : 'Mail',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.primaryTextColor)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: selectedButton
                      ? Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: CustomTextField(
                                enabled: false,
                                hintText: '+91',
                                suffixIcon: RotatedBox(
                                    quarterTurns: 45,
                                    child: Icon(Icons.arrow_forward_ios_outlined,
                                        size: 20)),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                                child: CustomTextField(
                              keyboardType: TextInputType.number,
                              controller: phoneCon,
                              maxLength: 10,
                              hintText: 'Please enter the phone number',
                                  style: TextStyle(color: Colors.white),
                            )),
                          ],
                        )
                      : CustomTextField(
                          controller: emailCon,
                          maxLines: 1,
                          hintText: 'please input your email',
                          style: TextStyle(color: Colors.white),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    children: [
                      SvgPicture.asset(Assets.iconsPassword,color: AppColors.goldencolortwo),
                      const SizedBox(width: 20),
                      textWidget(
                          text: 'Password',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.primaryTextColor)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: CustomTextField(
                    obscureText: hidePassword,
                    controller: passwordCon,
                    maxLines: 1,
                    hintText: 'Please enterPassword',
                    style: TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: SvgPicture.asset(hidePassword
                            ? Assets.iconsEyeClose
                            : Assets.iconsEyeOpen)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rememberPass = !rememberPass;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration: rememberPass ?BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(
                                    Assets.iconsCorrect)),
                            border: Border.all(
                                color: Colors.transparent
                                   ),
                            borderRadius: BorderRadiusDirectional.circular(50),
                          ):BoxDecoration(
                            border: Border.all(
                                color: AppColors.secondaryTextColor),
                            borderRadius: BorderRadiusDirectional.circular(50),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      textWidget(text: 'Remember password', fontSize: 14,color: AppColors.primaryTextColor),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: AppBtn(
                    title: 'Log in',
                    fontSize: 20,
                    onTap: () {
                      if (selectedButton==true) {
                        print("object");
                        authProvider.userLogin(context, phoneCon.text, passwordCon.text);
                      } else {
                        authProvider.userLogin(context, emailCon.text, passwordCon.text);
                      }
                    },
                    hideBorder: true,
                    gradient: AppColors.goldenGradient
                    // gradient: activeButton
                    //     ? AppColors.primaryGradient
                    //     : AppColors.inactiveGradient,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: AppBtn(
                    title: 'R e g i s t e r',
                    fontSize: 20,
                    titleColor: AppColors.gradientFirstColor,
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.registerScreen,arguments: '1');
                    },
                    gradient: AppColors.secondaryGradient,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _launchEmail();
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(Assets.iconsPassword, height: 60,),
                            textWidget(
                                text: 'Forgot password',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.primaryTextColor)
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            SvgPicture.asset(Assets.iconsCustomer, height: 60,),
                            textWidget(
                                text: 'Customer Service',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.primaryTextColor)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String email="techmetaverseplay@gmail.com";
  _launchEmail() async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }



}
