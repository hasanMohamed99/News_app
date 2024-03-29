import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news_app/modules/news_app/contact_us/contacts_screen.dart';
import 'package:news_app/modules/news_app/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, const ContactUsScreen());
                },
                icon: const Icon(Icons.contact_support_outlined),
              ),
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: NewsCubit.get(context).changeAppMode,
                icon: const Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: Stack(
            children: [
              cubit.screens[cubit.currentIndex],
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  height: cubit.bannerAd.size.height.toDouble(),
                  width: cubit.bannerAd.size.width.toDouble(),
                  child: AdWidget(ad: cubit.bannerAd),
                ),
              ),

            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
