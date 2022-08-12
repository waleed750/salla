import 'package:flutter/material.dart';
import 'package:salla/layout/shop_layout.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/modules/onboarding/boarding_screen.dart';
import 'package:salla/shared/common/constants.dart';
import 'package:salla/shared/network/local/cash_helper.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';
import 'package:salla/shared/styles/themes/themes.dart';

import 'layout/state_managment/cubit.dart';
import 'shared/common/bloc_observer.dart';
import 'shared/imports/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  DioHelper.init();

  Widget widget ;

  var onBoarding = CashHelper.getBool(key: 'onBoarding') ?? true;
  token = CashHelper.getString(key: 'token')??'';

  print('onBoarding : ${onBoarding}');

  if(!onBoarding )
    {
      if(token != '')
        {
            widget = ShopLayout();
        }
      else
        {
          widget = LoginScreen();
        }
    }
  else
    {
      widget = OnBoardingScreen();
    }

  BlocOverrides.runZoned(
        () {
          runApp( MyApp(home: widget,));
    },
    blocObserver: MyBlocObserver(),
  );


}

class MyApp extends StatelessWidget {

  final Widget home ;
  MyApp({required this.home});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
         BlocProvider(create: (context)=> ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()) ,
    ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home: home ,
        ));
  }
}
