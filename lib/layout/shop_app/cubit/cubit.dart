import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section3/layout/shop_app/cubit/states.dart';
import 'package:section3/models/shop_app/shop_home_model.dart';
import 'package:section3/modules/news_app/search/search_screen.dart';
import 'package:section3/modules/shop_app/categories/shop_categories_screen.dart';
import 'package:section3/modules/shop_app/favorites/shop_favorites_screen.dart';
import 'package:section3/modules/shop_app/products/shop_product_screen.dart';
import 'package:section3/modules/shop_app/setting/shop_setting_screen.dart';
import 'package:section3/shared/network/remote/dio_helper.dart';
import 'package:section3/shared/network/remote/end_point.dart';

import '../../../shared/componant/constants.dart';
import '../../../shared/network/local/cache_helper.dart';


class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialStates());



  static ShopCubit get(context)=> BlocProvider.of(context);

  int currentIndex=0;
  List<String> titles=[
    'Products',
    'Categories',
    'Favorites',
    'Setting',
  ];
  List<Widget> screen=[
    ShopProductScreen(),
    ShopCategoriesScreen(),
    ShopFavoritesScreen(),
    ShopSettingScreen()
  ];
  void changeIndex(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel? homeModel;
  void getHomeData()
  {
    emit(ShopLoadingHomeDataStates());

    DioHelper.getData(
      url: HOME,
      token:token
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      // printFullText(homeModel!.data!.banners[0].image!);
      // print(homeModel!.status);

      emit(ShopSuccessHomeDataStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataStates());
    });
  }
}

