import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Cubit/States.dart';
import '../models/ArchivedTasks.dart';
import '../models/doneTasks.dart';
import '../models/newTasks.dart';
import 'package:sqflite/sqflite.dart';

class App_Cubit extends Cubit<App_States>{

  App_Cubit() : super(AppInitialState());
  static App_Cubit get(context) => BlocProvider.of(context);
  bool isButtomSheet = false;
  IconData flotingIcon = Icons.edit;


  int currentIndex = 0;
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List<String> title_Screens = [
    "Tasks",
    "Done",
    "Archived",
  ];

  void ChangeNarBarIcon(int index){
    currentIndex = index;
    emit(AppChanghNavBar());
  }

  void creatDatabase(){
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print("database Created");
        database.execute("CREATE TABLE tasks (id INTEGER PRIMARY KEY  ,title TEXT,date TEXT,time TEXT,status TEXT)").then((value) {
          print("Table is Created");
        }).catchError(
            (error) => {print("error when Creat table ${error.toString()}")});
      },
      onOpen: (database) {
        print("database is opened");

         getDataFromDatabase(database);
      }).then((value) {
      database = value;
      emit(AppCreatDatabaseState());
    });
  }

   insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
     await database.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO tasks (title , date , time , status) VALUES("$title" , "$date" , "$time" , "new")'
      ).then((value){
        print("$value Inserted Successfully");
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print("error when insetr new row ${error.toString()}");
      });
    });
  }

   void getDataFromDatabase(database)  {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

     return database.rawQuery('SELECT * FROM tasks').then((value) {

       value.forEach( (element) {
         if(element['status'] == 'new'){
           newTasks.add(element);
         }else if(element['status'] == 'done'){
           doneTasks.add(element);
           print(doneTasks);
         }else{
           archivedTasks.add(element);
         }
       });

       emit(AppGetDatabaseState());
     });
   }

  void changeButtonSheatIcon({required bool isShow , required IconData icon }){
    isButtomSheet = isShow;
    flotingIcon = icon;
    emit(AppChangeButtonCheatState());
  }

  void update({required String status , required int id}){
     database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['${status}', '${id}']).then((value){
          getDataFromDatabase(database);
          emit(AppUpdateDatabaseState());
     });
  }

  void delete({required int id}){
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isDark = false;

  void changeMode(){
    isDark = !isDark;
    emit(AppChangeModeState());
  }

}