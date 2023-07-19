import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/cubit/states.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark,));
}

class MyApp extends StatelessWidget
{
  final bool? isDark;
  const MyApp( this.isDark, {super.key,});

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..initBannerAd()..changeAppMode(fromShared: isDark)..getBusiness()),
      ],
      child: BlocConsumer<NewsCubit,NewsStates>(
       listener: (context, state) {},
       builder: (context, state) {
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           theme: lightTheme,
           darkTheme: darkTheme,
           themeMode: NewsCubit.get(context).isDark? ThemeMode.dark: ThemeMode.light,
           home: const NewsLayout(),
         );
       },
      ),
    );
  }
}

