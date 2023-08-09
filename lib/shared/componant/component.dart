import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:section3/shared/cubit/cubit.dart';

Widget defaultButton({
   double width=double.infinity,
   Color background=Colors.blue,
   bool isUpperCase=true,
   double raduis=0.0,
   required final function,
   required String text,
})=>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text ,
          style: TextStyle(
            color: Colors.white,
      ),
    ),
  ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: background,
      ),
);

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword=false,
  required String labelText,
  final validate,
  required IconData prefix,
  final  suffixPressed,
  final onChanged,
  final onFile,
  final suffix,
  final onTap,
  bool isEnabled=true,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  onChanged:onChanged ,
  onFieldSubmitted: onFile,
  validator: validate,
  obscureText: isPassword,
  onTap: onTap,
  enabled: isEnabled,
  decoration: InputDecoration(
    labelText: labelText,
    border: OutlineInputBorder(),
    prefixIcon: Icon(
        prefix
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
          suffix
      ),
    ) : null,

  ),

);


Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 10,end: 10),
  child:   Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

Widget buildTasksItem(Map model ,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
              '${model['time']}'
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                  maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    // fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20,),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(status: 'done', id: model['id']);
            },
            icon:Icon (Icons.check_box,color: Colors.blue,)
        ),
        SizedBox(width: 20,),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(status: 'archive', id: model['id']);
            },
            icon:Icon (Icons.archive,color:Colors.black54 ,)
        ),
      ],
    ),
  ),
 onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
 },

);

Widget buildTasksEmpty({required List<Map> tasks})=> ConditionalBuilder(
  condition: tasks.length>0,
  builder: (BuildContext context) => ListView.separated(
    itemBuilder: (context,index)=>buildTasksItem(tasks[index],context),
    separatorBuilder: (context,index)=>Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    ),
    itemCount: tasks.length,
  ),
  fallback: (BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
          color:Colors.grey ,
        ),
        Text(
          'No Tasks Created Yet, Please Add New Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color:Colors.grey ,
          ),
        ),
      ],
    ),
  ),
);

Widget buildNewsItem(article ,context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage('${article['urlToImage']}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(width: 20,),
      Expanded(
        child: Container(
          height: 160,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                '${article['publishedAt']}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      )
    ],
  ),
) ;

Widget articleBuilder(list) => ConditionalBuilder(
  condition: list.length>0 ,
  builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildNewsItem(list[index],context),
      separatorBuilder:  (context,index)=>myDivider() ,
      itemCount: 10
  ),
  fallback: (context)=>Center(child: CircularProgressIndicator()),
);
