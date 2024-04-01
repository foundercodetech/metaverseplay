import 'package:metaverseplay/model/colorPredictionResult_provider.dart';
import 'package:metaverseplay/res/app_constant.dart';
import 'package:metaverseplay/res/provider/Beginner_provider.dart';
import 'package:metaverseplay/res/provider/Howtoplay_Provider.dart';
import 'package:metaverseplay/res/provider/TermsConditionProvider.dart';
import 'package:metaverseplay/res/provider/aboutus_provider.dart';
import 'package:metaverseplay/res/provider/addaccount_view_provider.dart';
import 'package:metaverseplay/res/provider/addacount_controller.dart';
import 'package:metaverseplay/res/provider/auth_provider.dart';
import 'package:metaverseplay/res/provider/betColorPrediction_provider.dart';
import 'package:metaverseplay/res/provider/betcolorpredictionTRX.dart';
import 'package:metaverseplay/res/provider/coins_provider.dart';
import 'package:metaverseplay/res/provider/contactus_provider.dart';
import 'package:metaverseplay/res/provider/deposit_provider.dart';
import 'package:metaverseplay/res/provider/feedback_provider.dart';
import 'package:metaverseplay/res/provider/giftcode_provider.dart';
import 'package:metaverseplay/res/provider/notification_provider.dart';
import 'package:metaverseplay/res/provider/privacypolicy_provider.dart';
import 'package:metaverseplay/res/provider/profile_provider.dart';
import 'package:metaverseplay/res/provider/promotion_count_provider.dart';
import 'package:metaverseplay/res/provider/slider_provider.dart';
import 'package:metaverseplay/res/provider/user_view_provider.dart';
import 'package:metaverseplay/res/provider/wallet_provider.dart';
import 'package:metaverseplay/res/provider/withdrawhistory_provider.dart';
import 'package:metaverseplay/utils/routes/routes.dart';
import 'package:metaverseplay/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/home/mini/Aviator/AviatorProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
        ChangeNotifierProvider(create: (context) => AviatorWallet()),
        ChangeNotifierProvider(create: (context) => UserViewProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => SliderProvider()),
        ChangeNotifierProvider(create: (context) => PromotionCountProvider()),
        ChangeNotifierProvider(create: (context) => DepositProvider()),
        ChangeNotifierProvider(create: (context) => WithdrawHistoryProvider()),
        ChangeNotifierProvider(create: (context) => AboutusProvider()),
        ChangeNotifierProvider(create: (context) => WalletProvider()),
        ChangeNotifierProvider(create: (context) => AddacountProvider()),
        ChangeNotifierProvider(create: (context) => AddacountViewProvider()),
        ChangeNotifierProvider(create: (context) => BeginnerProvider()),
        ChangeNotifierProvider(create: (context) => HowtoplayProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => GiftcardProvider()),
        ChangeNotifierProvider(create: (context) => CoinProvider()),
        ChangeNotifierProvider(create: (context) => ColorPredictionProvider()),
        ChangeNotifierProvider(create: (context) => BetColorResultProvider()),
        ChangeNotifierProvider(create: (context) => FeedbackProvider()),
        ChangeNotifierProvider(create: (context) => TermsConditionProvider()),
        ChangeNotifierProvider(create: (context) => PrivacyPolicyProvider()),
        ChangeNotifierProvider(create: (context) => ContactUsProvider()),
        ChangeNotifierProvider(create: (context) => BetColorResultProviderTRX()),
      ],
      child:  MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: (settings) {
          if (settings.name != null) {
            return MaterialPageRoute(
              builder: Routers.generateRoute(settings.name!),
              settings: settings,
            );
          }
          return null;
        },
      ),
    );
  }
}
