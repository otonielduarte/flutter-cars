import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cars/car/car.dart';
import 'package:cars/shared/services/base_api.dart';

class CarApi {
  static Future<List<Car>> getCarsByType(String type) async {
    try {
      final Uri carsUri = Uri.parse('$baseUrlV1/carros/tipo/$type');

      final response = await baseClient.get(carsUri);
      if (response.statusCode == 200) {
        List cars = jsonDecode(response.body);
        print('>>>>>>>>>> decoded >>>>>>>> $cars');
        return cars.map((value) => Car.fromJson(value)).toList();
      }
      return throw HttpException("Opssss it is wrong");
    } catch (error, exception) {
      print('Error >>>>>>> $error >>> $exception');
      return throw HttpException("Opssss it is wrong");
    }
  }
}
