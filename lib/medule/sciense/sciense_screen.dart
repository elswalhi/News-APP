import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class ScienseScreen extends StatelessWidget {
  const ScienseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,Newsstates>(
      listener:(context,state){} ,
      builder: (context,state){
        var list =NewsCubit.get(context).science;
        return ArticleComponent(list);
      },

    );
  }
}
