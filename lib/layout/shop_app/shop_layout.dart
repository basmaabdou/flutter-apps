import 'package:flutter/material.dart';
import 'package:section3/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:section3/shared/componant/component.dart';
import 'package:section3/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salla'
        ),
      ),
      body: TextButton(
        onPressed: (){
          CacheHelper.removeDate(key: 'token').then((value) {
            navigateFinish(context, ShopLoginScreen());
          });
        },
        child: Text(
          'LOGOUT'
        ),
      ),
    );
  }
}
