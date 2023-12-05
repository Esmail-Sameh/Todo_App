import 'package:flutter/material.dart';
import 'package:to_do/Cubit/Cubit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:to_do/Cubit/States.dart';

class Home extends StatelessWidget {

  var scafoldKey = GlobalKey<ScaffoldState>();
  var title_Controller = TextEditingController();
  var time_Controller = TextEditingController();
  var date_Controller = TextEditingController();
  var form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => App_Cubit()..creatDatabase(),
      child: BlocConsumer<App_Cubit , App_States>(
        listener:(context, state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          App_Cubit cubit = App_Cubit.get(context);
          return Scaffold(
            key: scafoldKey,
            appBar: AppBar(
              title: Text(
                '${cubit.title_Screens[cubit.currentIndex]}',
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      cubit.changeMode();
                    },
                    icon: Icon(Icons.brightness_4_outlined),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (!cubit.isButtomSheet) {
                  scafoldKey.currentState!.showBottomSheet((context) => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: form_key,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: title_Controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'title must not be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.title),
                                label: Text('Task Title'),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: time_Controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'time must not be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.watch_later_outlined),
                                label: Text('Task Time'),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
                              onTap: () {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                      .then((value) {
                                    time_Controller.text =
                                        value!.format(context).toString();
                                  });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: date_Controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'date must not be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_today),
                                label: Text('Task Date'),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse("2030-05-30"),
                                ).then((value) {
                                    date_Controller.text =
                                        DateFormat.yMMMd().format(value!);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      //vrr
                    ),
                  )).closed.then((value){
                    cubit.changeButtonSheatIcon(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeButtonSheatIcon(isShow: true, icon: Icons.add);
                } else {
                  if (form_key.currentState!.validate()) {
                     cubit.insertToDatabase(title:title_Controller.text, time: time_Controller.text, date: date_Controller.text);
                  }
                }
              },
              child: Icon(cubit.flotingIcon),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.task),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: "Archived",
                ),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeNarBarIcon(index);
                print(index);

              },
            ),
          );
        },
      ),
    );
  }

}