import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/layout/Home_layout.dart';
import 'package:news_app/network/local/cach_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
   await CacheHelper.init().then((value){
     print(value);
   });
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  isDark==null?isDark=true:isDark;
  runApp( MyApp(isDark));

}

class MyApp extends StatelessWidget {
   late final bool isDark;
    MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getBuisness()..changeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit,Newsstates>(
        listener:(context,state){},
        builder: (context,state){
          return MaterialApp(
            theme: ThemeData
              (
              textTheme: const TextTheme(
                bodyText1:  TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              primarySwatch:Colors.deepOrange ,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
                elevation: 20,
              ),
              appBarTheme:const AppBarTheme(
                titleSpacing: 20,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                elevation: 0 ,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,

                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark
                ),
              ) ,
            ),
            darkTheme: ThemeData(
              textTheme:const TextTheme(
                bodyText1:  TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ) ,
              bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey,
                elevation: 20,
              ),

              primarySwatch:Colors.deepOrange ,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 0 ,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,

                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor:HexColor('333739'),
                    statusBarIconBrightness: Brightness.light
                ),
              ) ,
            ),
            themeMode:NewsCubit.get(context).isDark? ThemeMode.dark :ThemeMode.light,
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          );
        },

      ),
    );
  }

}