import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:section3/layout/news_app/cubit/cubit.dart';
import 'package:section3/layout/news_app/cubit/states.dart';
import 'package:section3/shared/componant/component.dart';

class BuisnessScreen extends StatelessWidget {
  const BuisnessScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).business;


        return ScreenTypeLayout(
          mobile: Builder(
            builder: (BuildContext context) { 
              NewsCubit.get(context).setDesktop(false);
              return articleBuilder(list);
            },
            
          ),
          desktop: Builder(
            builder: (context) {
              NewsCubit.get(context).setDesktop(true);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: articleBuilder(list)
                  ),
                  if(list.length>0)
                    Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      height: double.infinity,
                      child: Text(
                        '${list[NewsCubit.get(context).selectedBusinessItem]['description']}',
                        style: const TextStyle(
                          fontSize: 20
                        ),
                      ),
                    )
                  )
                ],
              );
            }
          ),
          breakpoints: const ScreenBreakpoints(desktop: 800, tablet: 600, watch: 100),
        );
      },
    );
  }
}
