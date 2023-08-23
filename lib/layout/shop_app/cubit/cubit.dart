import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section3/layout/shop_app/cubit/states.dart';
import 'package:section3/models/shop_app/Shop_login_model.dart';
import 'package:section3/models/shop_app/change_favorites-model.dart';
import 'package:section3/models/shop_app/shop_home_model.dart';
import 'package:section3/modules/news_app/search/search_screen.dart';
import 'package:section3/modules/shop_app/categories/shop_categories_screen.dart';
import 'package:section3/modules/shop_app/favorites/shop_favorites_screen.dart';
import 'package:section3/modules/shop_app/products/shop_product_screen.dart';
import 'package:section3/modules/shop_app/setting/shop_setting_screen.dart';
import 'package:section3/shared/network/remote/dio_helper.dart';
import 'package:section3/shared/network/remote/end_point.dart';

import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/shop_categories_model.dart';
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


  Map<int,bool> favorites={};
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

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id! : element.in_favorites!,
        });
      });


      print(favorites.toString());

      emit(ShopSuccessHomeDataStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataStates());
    });
  }

  
  CategoriesModel? categoriesModel;
  void getCategoriesData()
  {

    DioHelper.getData(
        url: CATEGORIES,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // printFullText(homeModel!.data!.banners[0].image!);
      // print(homeModel!.status);

       
      emit(ShopSuccessCategoryDataStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoryDataStates());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesStates());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesStates());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites()
  {

    emit(ShopLoadingFavoritesStates());

    DioHelper.getData(
        url: FAVORITES,
        token: token
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetFavoritesStates());
    });
  }

  ShopLoginModel? userModel;
  void getUserData()
  {

    DioHelper.getData(
      url: PROFILE,
      token: token
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      // print(userModel!.data!.name);


      emit(ShopSuccessUserDataStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorProfileStates());
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name!);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
