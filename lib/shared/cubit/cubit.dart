import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/current_model.dart';
import 'package:weather_app/shared/cubit/states.dart';

import '../dio_helper.dart';

class WeatherCubit extends Cubit<WeatherStates>
{
  //WeatherCubit(super.initialState);
  WeatherCubit() : super(WeatherInitialState());
  static WeatherCubit get(context) => BlocProvider.of(context);

  CurrentModel? currentModel;
  String city = 'minya';
  void getWeather()
  {
    emit(WeatherGetDataLoadingState());
    DioHelper.getData(
      url: 'data/2.5/weather?',
      query: {
        'q': city,
        'apiKey': '163d017e463b61865ee22cfcf586cd86',
      },
    ).then((value) {
      currentModel = CurrentModel.fromJson(value.data);
      print(value.data['name']);
      print(value.data['weather'][0]['icon']);
      emit(WeatherGetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(WeatherGetDataErrorState(error.toString()));
    });
  }

  // void ChangeCity(String value){
  //
  //   if(value.isNotEmpty)
  //     {
  //       value == city;
  //       emit(WeatherChangeCitySuccessState());
  //     }
  //   else{
  //     emit(WeatherChangeCityErrorState());
  //   }
  // }

  // void get30Days()
  // {
  //   emit(WeatherGetDataLoadingState());
  //   DioHelper.getData(
  //     url: 'data/2.5/forecast/daily?',
  //     query: {
  //       'q': city,
  //       'apiKey': '163d017e463b61865ee22cfcf586cd86',
  //     },
  //   ).then((value) {
  //     currentModel = CurrentModel.fromJson(value.data);
  //     print(value.data['name']);
  //     print(value.data['weather'][0]['icon']);
  //     emit(WeatherGetDataSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(WeatherGetDataErrorState(error.toString()));
  //   });
  // }

  Future getSpecificWeather(String City)async
  {
    emit(WeatherGetSpecificDataLoadingState());
   return await DioHelper.getData(
      url: 'data/2.5/weather?',
      query: {
        'q': City,
        'apiKey': '163d017e463b61865ee22cfcf586cd86',
      },
    ).then((value) {
      currentModel = CurrentModel.fromJson(value.data);
      print(value.data['name']);
      print(value.data['weather'][0]['icon']);
      emit(WeatherGetSpecificDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(WeatherGetSpecificDataErrorState(error.toString()));
    });
  }

}