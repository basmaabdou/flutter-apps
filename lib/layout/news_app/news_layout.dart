import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section3/layout/news_app/cubit/cubit.dart';
import 'package:section3/layout/news_app/cubit/states.dart';
import 'package:section3/modules/news_app/search/search_screen.dart';
import 'package:section3/shared/componant/component.dart';
import 'package:section3/shared/cubit/cubit.dart';
class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {
        },
      builder: (BuildContext context, Object? state) {
        var cubit=NewsCubit.get(context);
        return Scaffold(

          appBar: AppBar(
            title:Text
              (
              cubit.titles[cubit.currentIndex],
            ) ,
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search)
              ),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports),
                  label: 'Sports'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science),
                  label: 'Science'
              ),
            ],
          ),
        );
      },
    );
  }
}
