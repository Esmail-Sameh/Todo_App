import 'package:flutter/material.dart';
import '../Cubit/Cubit.dart';
import '../Cubit/States.dart';
import '../compount/compount.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<App_Cubit , App_States>(
    listener: (context, state) {},
    builder: (context, state) {
    var tasks = App_Cubit.get(context).doneTasks;
    return tasksBuilder(tasks: tasks);
    },
    );
  }
}
