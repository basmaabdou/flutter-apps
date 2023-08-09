import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section3/shared/componant/component.dart';
import 'package:section3/shared/cubit/cubit.dart';
import 'package:section3/shared/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){} ,
      builder: (context,state){
        var tasks=AppCubit.get(context).archiveTasks;
        return  buildTasksEmpty(tasks: tasks);
      },
    );
  }
}
