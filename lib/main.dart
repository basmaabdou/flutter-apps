import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:section3/layout/news_app/cubit/cubit.dart';
import 'package:section3/layout/news_app/cubit/states.dart';
import 'package:section3/layout/news_app/news_layout.dart';
import 'package:section3/layout/shop_app/cubit/states.dart';
import 'package:section3/layout/shop_app/shop_layout.dart';
import 'package:section3/layout/todo_app/todoLayout.dart';
import 'package:section3/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:section3/shared/bloc_observed.dart';
import 'package:section3/shared/componant/constants.dart';
import 'package:section3/shared/cubit/cubit.dart';
import 'package:section3/shared/cubit/states.dart';
import 'package:section3/shared/network/local/cache_helper.dart';
import 'package:section3/shared/network/remote/dio_helper.dart';
import 'package:section3/shared/styles/themes.dart';

import 'layout/shop_app/cubit/cubit.dart';
import 'modules/shop_app/login&register/Login&register_cubit/cubit.dart';
import 'modules/shop_app/login&register/shop_login_screen.dart';
import 'modules/shop_app/search/cubit/cubit.dart';
void main() async{
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark',);
  bool? onBoarding= CacheHelper.getData(key: 'onBoarding',);
  token=CacheHelper.getData(key: 'token' );
  print(token);

  Widget widget;
  if(onBoarding!=null){
    if(token !=null) {
      widget = ShopLayout();
    }else {
      widget = ShopLoginScreen();
    }
  }else{
    widget=OnBoardingScreen();
  }
//
runApp(MyApp(
  isDark:isDark,
  startWidget: widget,
));



}


class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool? isDark;
  // final bool? onBoarding;
  final Widget? startWidget;
  MyApp( {this.isDark, this.startWidget});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit(InitialNews())..getBusiness()..getSports()..getScience()),
        BlocProvider(create: (context)=> AppCubit(AppInitialState)..changeMode(fromShared: isDark),),
        BlocProvider(create: (context)=> ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData()),
        BlocProvider(create: (context)=>ShopLoginRegisterCubit()),
        BlocProvider(create: (context)=>SearchCubit()),
      ],
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              //light
              theme: lightTheme,
              // dark and edit
              darkTheme: darkTheme,
              // determine dark or light
              themeMode: AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              // home:onBoarding!= null? ShopLoginScreen() : OnBoardingScreen(),
              home: NewsLayout(),
            );
          },
        ),
      );

  }


}
