import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section3/layout/news_app/cubit/cubit.dart';
import 'package:section3/layout/news_app/cubit/states.dart';
import 'package:section3/models/shop_app/favorites_model.dart';
import 'package:section3/modules/shop_app/search/cubit/cubit.dart';
import 'package:section3/modules/shop_app/search/cubit/states.dart';
import 'package:section3/shared/componant/component.dart';

class ShopSearchScreen extends StatelessWidget {

  var searchController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SearchCubit,SearchStates>(
      listener: (BuildContext context, SearchStates state) {  },
      builder: (BuildContext context, SearchStates state) {
        return  Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultTextForm(
                    controller: searchController,
                    type: TextInputType.text,
                    labelText: 'Product Search',
                    validate: (value){
                      if(value.isEmpty){
                        return 'search must have Clear words';
                      }
                      return null;
                    },
                    prefix: Icons.search,
                    onSubmit: (String text){
                      SearchCubit.get(context).searchProduct(searchController.text);
                    }
                ),
                SizedBox(
                  height: 20,
                ),
                if(state is ShopSearchLoadingStates)
                LinearProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                if(state is ShopSearchSuccessStates)
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index)=> buildListProduct(SearchCubit.get(context).searchModel!.data!.data![index], context,isOldPrice: false),
                      separatorBuilder: (context,index)=> myDivider(),
                      itemCount: SearchCubit.get(context).searchModel!.data!.data!.length
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
