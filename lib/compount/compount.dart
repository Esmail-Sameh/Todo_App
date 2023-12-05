
import 'package:flutter/material.dart';
import 'package:to_do/Cubit/Cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

Widget buildTaskItem(Map model , context)=>Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(

    padding: const EdgeInsets.all(16.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 35,

          child: Text('${model['time']}'),

        ),

        SizedBox(width: 10,),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model['title']}',

                style: TextStyle(

                  fontSize: 20,

                  fontWeight: FontWeight.bold,

                ),

              ),

              SizedBox(height: 10,),

              Text(

                '${model['date']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),

            ],

          ),

        ),

        SizedBox(width: 10,),

        IconButton(

          onPressed: (){

            App_Cubit.get(context).update(status: 'done', id: model['id']);

          },

          icon: Icon(Icons.check_box),

          color: Colors.green,

        ),

        SizedBox(width: 10,),

        IconButton(

          onPressed: (){

            App_Cubit.get(context).update(status: 'archive', id: model['id']);

          },

          icon: Icon(Icons.archive),

          color: Colors.grey,

        ),

      ],

    ),

  ),
  onDismissed: (direction) {
    App_Cubit.get(context).delete(id: model['id'],);
  },
);

Widget tasksBuilder({
  required List<Map> tasks
})=>ConditionalBuilder(
  condition:tasks.length > 0 ,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context , index)=> buildTaskItem(tasks[index] , context),
    separatorBuilder: (context , index) => Padding(padding: const EdgeInsets.only(left: 20), child: Container(
      width: double.infinity,
      height: 2,
      color: Colors.grey[300],
    ),),
    itemCount:tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style:TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold
          ),

        ),
      ],
    ),
  ),
);