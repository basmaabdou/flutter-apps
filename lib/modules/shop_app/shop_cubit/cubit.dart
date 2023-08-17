import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section3/models/login/Shop_login_model.dart';
import 'package:section3/modules/shop_app/shop_cubit/states.dart';
import 'package:section3/shared/network/remote/dio_helper.dart';
import 'package:section3/shared/network/remote/end_point.dart';

class ShopCubit extends Cubit<ShopLoginStates>{
  ShopCubit() : super(InitialLoginShop());

  static ShopCubit get(context)=> BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
}){
    emit(ShopLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password
        }
    ).then((value) {
      loginModel=ShopLoginModel.formJson(value.data);
      // print(loginModel!.status);
      // print(loginModel!.message);
      // print(loginModel!.data!.token);
      emit(ShopSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopErrorState(error));
    });
  }


  IconData suffix= Icons.visibility;
  bool isPassword=true;
  void changePasswordIcons(){
    isPassword=! isPassword;
    suffix= isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ShopPasswordChangeState());
  }
}