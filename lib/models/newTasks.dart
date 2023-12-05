import 'package:flutter/material.dart';
import 'package:to_do/Cubit/Cubit.dart';
import 'package:to_do/Cubit/States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/compount/compount.dart';


class NewTasks extends StatefulWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  State<NewTasks> createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<App_Cubit , App_States>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = App_Cubit.get(context).newTasks;
        return Scaffold(
          body: tasksBuilder(tasks: tasks),
        );
      },
    );
  }
}