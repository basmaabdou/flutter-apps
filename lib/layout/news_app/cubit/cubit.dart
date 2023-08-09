import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section3/layout/news_app/cubit/states.dart';
import 'package:section3/modules/buisness/buisness.dart';
import 'package:section3/modules/science/science.dart';
import 'package:section3/modules/settings/settings.dart';
import 'package:section3/modules/sports/sports.dart';
import 'package:section3/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit(NewsStates initialState) : super(InitialNews());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<String> titles=[
    'Buisness',
    'Sports',
    'Science',
    'Settings'
  ];
  List<Widget> screens=[
     BuisnessScreen(),
     SportScreen(),
     ScienceScreen(),
  ];
  int currentIndex=0;
  void changeIndex(index){
     currentIndex=index;
     // if(index==1)
     //   getSport();
     // if(index==2)
     //   getScience();
     emit(ChangeBottomNavBar());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'us',
        'category': 'business',
        'apiKey':'28988366cd504af9b749397e49c45648',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'us',
          'from':'2023-07-09',
          'sortBy':'publishedAt',
          'apiKey':'28988366cd504af9b749397e49c45648',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'sources':'bbc-news',
          'from':'2023-07-09',
          'sortBy':'publishedAt',
          'apiKey':'28988366cd504af9b749397e49c45648',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetScienceSuccessState());
    }
  }
}