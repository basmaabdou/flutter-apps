
import '../../../models/shop_app/Shop_login_model.dart';

abstract class ShopLoginStates{}

class InitialLoginShop extends ShopLoginStates{}

class ShopLoadingState extends ShopLoginStates{}

class ShopSuccessState extends ShopLoginStates{
  final ShopLoginModel loginModel;

  ShopSuccessState(this.loginModel);
}

class ShopErrorState extends ShopLoginStates{
  final String error;

  ShopErrorState(this.error);
}

class ShopPasswordChangeState extends ShopLoginStates{}