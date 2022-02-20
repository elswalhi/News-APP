import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/medule/SettingScreen/SettingScreen.dart';
import 'package:news_app/medule/business/business_screen.dart';
import 'package:news_app/medule/sciense/sciense_screen.dart';
import 'package:news_app/medule/sports/sports_screen.dart';
import 'package:news_app/network/local/cach_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<Newsstates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = const[
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),

  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienseScreen(),
    SettingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (currentIndex == 0) {
      getBuisness();
    }
    if (currentIndex == 1) {
      getSports();
    }
    if (currentIndex == 2) {
      getScience();
    }
    emit(NewsBottonNavState());
  }

  List<dynamic> buisness = [];

  void getBuisness() {
    emit(newsGetBuisnessLoding());
    DioHelper.getData(
        url: 'v2/top-headlines',
        quary: {
          'country': 'eg',
          'category': 'business',
          'apiKey': 'bce0613947e14ce0b67a84a136941f77',
        }).then((value) {
      print(value?.data.toString());
      buisness = value!.data['articles'];
      emit(newsGetSportsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(newsGetSportsError(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(newsGetSportsLoding());
    if (sports.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          quary: {
            'country': 'eg',
            'category': 'sport',
            'apiKey': 'bce0613947e14ce0b67a84a136941f77',
          }).then((value) {
        print(value?.data.toString());
        sports = value!.data['articles'];
        emit(newsGetSportsSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(newsGetSportsError(error.toString()));
      });
    }
    else {
      emit(newsGetSportsSuccess());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(newsGetSciencesLoding());
    if (science.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          quary: {
            'country': 'eg',
            'category': 'science',
            'apiKey': 'bce0613947e14ce0b67a84a136941f77',
          }).then((value) {
        print(value?.data.toString());
        science = value!.data['articles'];
        emit(newsGetSciencesSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(newsGetSciencesError(error.toString()));
      });
    }
  else {
  emit(newsGetSciencesSuccess());
  }}
  List<dynamic> search = [];

  void getSearch(String? value) {
    emit(newsGetSearchLoding());
    search = [];
    DioHelper.getData(
        url: 'v2/everything',
        quary: {

         'q':'$value',
          'apiKey': 'bce0613947e14ce0b67a84a136941f77',
        }).then((value) {
      print(value?.data.toString());
      search = value!.data['articles'];
      emit(newsGetSearchSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(newsGetSearchError(error.toString()));
      });
  }
  bool isDark = false;
  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppMode());
    }
    else {
      isDark = !isDark;
      CacheHelper.putBoolean(
        key: 'isDark',
        value: isDark,
      ).then((value) {
        emit(ChangeAppMode());
      });
    }
  }
}