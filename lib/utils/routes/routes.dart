import 'package:metaverseplay/res/aap_colors.dart';
import 'package:metaverseplay/utils/routes/routes_name.dart';
import 'package:metaverseplay/view/account/History/betting_history.dart';
import 'package:metaverseplay/view/account/History/transaction_history.dart';
import 'package:metaverseplay/view/account/gifts.dart';
import 'package:metaverseplay/view/account/service_center/feedback.dart';
import 'package:metaverseplay/view/account/service_center/setting.dart';
import 'package:metaverseplay/view/auth/login_screen.dart';
import 'package:metaverseplay/view/auth/register_screen.dart';
import 'package:metaverseplay/view/bottom/bottom_nav_bar.dart';
import 'package:metaverseplay/view/home/lottery/WinGo/win_go_screen.dart';
import 'package:metaverseplay/view/home/mini/Aviator/home_page_aviator.dart';
import 'package:metaverseplay/view/promotion/level_screen.dart';
import 'package:metaverseplay/view/splash_screen.dart';
import 'package:metaverseplay/view/wallet/add_bank_account.dart';
import 'package:metaverseplay/view/wallet/deposit_history.dart';
import 'package:metaverseplay/view/wallet/deposit_screen.dart';
import 'package:metaverseplay/view/wallet/select_bank.dart';
import 'package:metaverseplay/view/wallet/withdraw_screen.dart';
import 'package:metaverseplay/view/wallet/withdrawal_history.dart';
import 'package:flutter/material.dart';
import '../../res/components/text_widget.dart';

class Routers {
  static WidgetBuilder generateRoute(String routeName) {
    switch (routeName) {
      case RoutesName.splashScreen:
        return (context) => const SplashScreen();
    case RoutesName.bottomNavBar:
      return (context) => const BottomNavBar();
      case RoutesName.loginScreen:
        return (context) => const LoginScreen();
      case RoutesName.registerScreen:
        return (context) => const RegisterScreen();
      case RoutesName.depositScreen:
        return (context) => const DepositScreen();
      case RoutesName.withdrawScreen:
        return (context) =>  const WithdrawScreen();
      case RoutesName.addBankAccount:
        return (context) => const AddBankAccount();
      case RoutesName.depositHistory:
        return (context) => const DepositHistory();
      case RoutesName.withdrawalHistory:
        return (context) => const WithdrawHistory();
      case RoutesName.selectBank:
        return (context) => const SelectBank();
      case RoutesName.aviatorGame:
        return (context) => const GameAviator();
      case RoutesName.winGoScreen:
        return (context) => const WinGoScreen();
      case RoutesName.levelscreen:
        return (context) =>  LevelScreen();
      case RoutesName.Bethistoryscreen:
        return (context) => const BetHistory();
      case RoutesName.Transactionhistoryscreen:
        return (context) => const TransactionHistory();
      case RoutesName.settingscreen:
        return (context) => const Setting();
      case RoutesName.feedbackscreen:
        return (context) => const Feedback_page();
      case RoutesName.giftsscreen:
        return (context) =>const GiftsPage();
      // case RoutesName.subscription:
      //   return (context) => const Subscription();
      default:
        return (context) => Scaffold(
              body: Center(
                child: textWidget(
                    text: 'No Route Found!',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryTextColor),
              ),
            );
    }
  }
}
