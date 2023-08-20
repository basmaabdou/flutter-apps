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
          builder:(context)=> ListView.separated(
            itemBuilder: (context, index) => buildFavoriteItem(ShopCubit.get(context).favoritesModel!.data!.data![index],context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ) ,
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }



  Widget buildFavoriteItem(FavoritesData model , context)=>Padding (
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product!.image!),
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
              if(model.product!.discount !=0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.product!.price.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          color: defaultColor
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    if(model.product!.discount !=0)
                      Text(
                        model.product!.oldPrice.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                           ShopCubit.get(context).changeFavorites(model.product!.id!);
                        },
                        icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: ShopCubit.get(context).favorites[model.product!.id!]! ? defaultColor : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
