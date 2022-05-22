import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/on_boarding/on_boarding.dart';
import 'package:shop_app/modules//login/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/local/ob_server.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/login/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () {
      //LoginCubit();
    },
    blocObserver: MyBlocObserver(),
  );

  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getBoolenData("onBoarding");
  String? userToken = CacheHelper.getData("UserToken") ?? "";
  print("Is On Boarding : ${onBoarding}");
  print("Is LogIn : ${userToken == "" ? "No LogIn" : userToken}");
  runApp(ShopApp(onBoarding!,userToken!));
}


class ShopApp extends StatelessWidget {

  final bool onBoarding;
  final String userToken;
  ShopApp(this.onBoarding,this.userToken);

  returnedWidget(){
    if (onBoarding == true) {
      if (userToken.isEmpty) {
        return LoginScreen();
      } else {
        return HomeLayout();
      }
    } else {
      return OnBoardingScreen();
    }
  }



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      theme: myTheme(),
      home: returnedWidget(),
    );
  }
}
