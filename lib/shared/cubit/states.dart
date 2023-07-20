class WeatherStates{}
class WeatherInitialState extends WeatherStates{}
class WeatherGetDataLoadingState extends WeatherStates{}
class WeatherGetDataSuccessState extends WeatherStates{}
class WeatherGetDataErrorState extends WeatherStates{
  final error;
  WeatherGetDataErrorState(this.error);

}

class WeatherChangeCityLoadingState extends WeatherStates{}
class WeatherChangeCitySuccessState extends WeatherStates{}
class WeatherChangeCityErrorState extends WeatherStates{}



class WeatherGetSpecificDataLoadingState extends WeatherStates{}
class WeatherGetSpecificDataSuccessState extends WeatherStates{}
class WeatherGetSpecificDataErrorState extends WeatherStates{
  final error;
  WeatherGetSpecificDataErrorState(this.error);

}