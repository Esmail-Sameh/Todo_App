import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/Cubit/Cubit.dart';
import 'package:to_do/Cubit/States.dart';
import 'package:to_do/homeLayout/home_Layout.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(app());
}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => App_Cubit(),
      child: BlocConsumer<App_Cubit , App_States>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = App_Cubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  color: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,

                  )
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: Colors.white
              ),
            ),

            darkTheme: ThemeData(
              iconTheme: IconThemeData(
                  color: Colors.white
              ),
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                  color: HexColor('333739'),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  ),

                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,

                  )
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: HexColor('333739')
              ),
            ),

            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light ,

            home: Home(),

          );
        },
      ),
    );
  }
}
