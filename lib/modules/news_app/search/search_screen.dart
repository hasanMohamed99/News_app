import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();
  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                  label: 'Search',
                  controller: searchController,
                  type: TextInputType.text,
                  validator: (value) {
                    if(value!.isEmpty){
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              list.isEmpty?
              const Center(child: CircularProgressIndicator(color: Colors.teal,)):
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildArticleItem(list[index],context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: list.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
