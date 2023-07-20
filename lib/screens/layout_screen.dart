
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/shared/cubit/cubit.dart';
import 'package:weather_app/shared/cubit/states.dart';

class LayoutScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "Weather today",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xBB5C83E8)),
            ),
          ),
          body: ConditionalBuilder(
              condition: WeatherCubit.get(context).currentModel != null,
              builder: (context) {
                return ListView(
                  children: [
                    Container(
                      height: 500,
                      padding: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: Color(0x52B4CCFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextField(
                                  controller: _cityController,
                                  onChanged: (value){

                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter Your City',
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  WeatherCubit.get(context).getSpecificWeather(_cityController.text.toString()).then((value) {
                                    Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => LayoutScreen(),)
                                    );
                                  });
                                },
                                icon: Icon(Icons.send),
                              ),
                            ],
                          ),
                          Card(
                            margin: EdgeInsets.all(10),
                            elevation: 15,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide.none,
                            ),
                            // color: Colors.white24,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${WeatherCubit.get(context).currentModel?.name}',
                                      style: TextStyle(fontSize: 25)),
                                  Text(
                                      '${DateFormat().add_MMMMEEEEd().format(DateTime.now())}',
                                      style: TextStyle(fontSize: 10)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        color: Color(0x52B4CCFF),
                                        height: 100,
                                        width: 100,
                                        child: Image(
                                          fit: BoxFit.fitHeight,
                                          image: NetworkImage(
                                            'http://openweathermap.org/img/w/${WeatherCubit.get(context).currentModel?.weather![0].icon}.png',
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                              '${WeatherCubit.get(context).currentModel!.weather![0].description}',
                                              style: TextStyle(fontSize: 20)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${((WeatherCubit.get(context).currentModel!.main!.temp)! - 273.15).toStringAsFixed(2)}\u2103',
                                            style: TextStyle(fontSize: 35),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          'Cloud: ${WeatherCubit.get(context).currentModel!.clouds!.all} %'),
                                      Text(
                                          'Pressure: ${WeatherCubit.get(context).currentModel!.main!.pressure} hpa'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          'Humidity: ${WeatherCubit.get(context).currentModel!.main!.humidity} %'),
                                      Text(
                                          'Wind: ${WeatherCubit.get(context).currentModel!.wind!.speed} m/s'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              fallback: (context) => Center(child: CircularProgressIndicator(),),
          )

        );
      },
    );
  }
}
