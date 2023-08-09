import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:section3/layout/news_app/news_layout.dart';
import 'package:section3/layout/todo_app/todoLayout.dart';
import 'package:section3/modules/bmi/bmi_screen.dart';
import 'package:section3/modules/counter/counter_screen.dart';
import 'package:section3/modules/login/login_screen.dart';
import 'package:section3/shared/bloc_observed.dart';
import 'package:section3/shared/cubit/cubit.dart';
import 'package:section3/shared/cubit/states.dart';
import 'package:section3/shared/network/local/cache_helper.dart';
import 'package:section3/shared/network/remote/dio_helper.dart';

void main() async{
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  // sharedPreference
  bool? isDark=CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark!));
}
class MyApp extends StatelessWidget {
  // constructor    (call)
  //build       (call)

  // sharedPreference
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)  =>AppCubit(AppInitialState)..changeMode(fromShared: isDark),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            //light
            theme: ThemeData(
                primarySwatch:Colors.purple ,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                    color: Colors.white,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.black54,
                        size: 30
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.purple,
                  unselectedItemColor: Colors.grey,
                  elevation: 30.0,
                  backgroundColor: Colors.white,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.purple,
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black
                    ),
                    bodyText2: TextStyle(
                        color: Colors.grey
                    )
                )
            ),
            // dark and edit
            darkTheme: ThemeData(
                primarySwatch:Colors.purple ,
                appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                    backgroundColor: HexColor('333739'),
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.white,
                        size: 30
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.purple,
                  unselectedItemColor: Colors.grey,
                  elevation: 30.0,
                  backgroundColor: HexColor('333739'),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: HexColor('333739'),
                ),
                scaffoldBackgroundColor: HexColor('333739'),

                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white
                    ),
                    bodyText2: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                    )
                )

            ),
            // determine dark or light
            themeMode: AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: NewsLayout(),
          );
        },
      ),
    );

  }

}
