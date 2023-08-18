import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section3/layout/shop_app/cubit/cubit.dart';
import 'package:section3/layout/shop_app/cubit/states.dart';
import 'package:section3/models/shop_app/shop_home_model.dart';
import 'package:section3/shared/styles/colors.dart';

class ShopProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, ShopStates state) {  },
      builder: (BuildContext context, ShopStates state) {
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          builder: (BuildContext context) => buildProductBuilder(cubit.homeModel!) ,
          fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),);
      },
    );
  }


  Widget  buildProductBuilder(HomeModel model)=> SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        CarouselSlider(
            items: model.data!.banners.map((e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 2.0
            )
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.7,
            children: List.generate(
                model.data!.products.length,
                (index) => buildGridProduct(model.data!.products[index]),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildGridProduct(ProductModel model)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                image: NetworkImage(model.image!),
                    width: double.infinity,
                    height: 200,
            ),
            if(model.discount !=0)
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
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    // علشان هو مش string
                    '${model.price.round()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount != 0)
                  Text(
                    // علشان هو مش string
                    '${model.old_price.round()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                      onPressed: (){},
                      icon: Icon(Icons.favorite_border)
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
