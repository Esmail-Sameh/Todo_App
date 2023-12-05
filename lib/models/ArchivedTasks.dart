import 'package:flutter/material.dart';
import '../Cubit/Cubit.dart';
import '../Cubit/States.dart';
import '../compount/compount.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedTasks extends StatefulWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  State<ArchivedTasks> createState() => _ArchivedTasksState();
}

class _ArchivedTasksState extends State<ArchivedTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<App_Cubit , App_States>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = App_Cubit.get(context).archivedTasks;
        return tasksBuilder(tasks: tasks);

      },
    );
  }
}
