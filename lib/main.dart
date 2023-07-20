import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screens/layout_screen.dart';
import 'package:weather_app/shared/cubit/cubit.dart';

import 'shared/dio_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Bloc.observer;
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..getWeather(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LayoutScreen(),
      ),
    );
  }
}

