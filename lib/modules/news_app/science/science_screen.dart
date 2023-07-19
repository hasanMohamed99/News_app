import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/styles/colors.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder: (context,state) {
        Brightness curBright = Theme.of(context).brightness;
        var list = [];
        NewsCubit.get(context).science.forEach((element) {
          if(element["urlToImage"] != null) list.add(element);
        });
        return list.isEmpty?
        const Center(child: CircularProgressIndicator(color: defaultColor,)) :
        ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildArticleItem(list[index],context, currentBrightness: curBright),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length,
        );
      },
    );
  }
}
