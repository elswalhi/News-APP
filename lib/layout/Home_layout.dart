import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/medule/shearch/search.dart';
import 'package:news_app/shared/components/components.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,Newsstates>(
       listener: (context,state){},
      builder: (context,state){
         var cubit =NewsCubit.get(context);
         return Scaffold(
           //APPBAR
           appBar: AppBar(
             title: Text("NewsApp"),
             actions: [
               IconButton(onPressed: (){
                 navigateTo(context, SearchScreen());
               }, icon: Icon(Icons.search)),
               IconButton(onPressed: (){
                 cubit.changeMode();
               }, icon: Icon(Icons.brightness_4_outlined)),

             ],
           ),
           bottomNavigationBar: BottomNavigationBar(
             items: cubit.bottomItems,
             currentIndex: cubit.currentIndex,
             onTap: (index){
               cubit.changeBottomNavBar(index);
             },
           ),
           body:cubit.screens[cubit.currentIndex]  ,
         );
      },
    );
  }
}
