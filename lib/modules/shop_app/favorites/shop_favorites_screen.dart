import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section3/layout/shop_app/cubit/cubit.dart';
import 'package:section3/layout/shop_app/cubit/states.dart';
import 'package:section3/models/shop_app/favorites_model.dart';
import 'package:section3/shared/componant/component.dart';

import '../../../shared/styles/colors.dart';

class ShopFavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, ShopStates state) {  },
      builder: (BuildContext context, ShopStates state) {
        return  ConditionalBuilder(
         condition: state is! ShopLoadingFavoritesStates ,
          builder:(context)=>ListView.separated(
            itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ) ,
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }




}
