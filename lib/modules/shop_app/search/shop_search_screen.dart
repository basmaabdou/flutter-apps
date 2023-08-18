import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section3/layout/news_app/cubit/cubit.dart';
import 'package:section3/layout/news_app/cubit/states.dart';
import 'package:section3/shared/componant/component.dart';

class ShopSearchScreen extends StatelessWidget {
  var searchController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(child: Text('Search')),
    );
  }
}
