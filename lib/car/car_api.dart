import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cars/car/car.dart';
import 'package:cars/login/user.dart';
import 'package:cars/shared/services/base_api.dart';

class CarApi {
  static Future<List<Car>> getCarsByType(String type) async {
    final Uri carsUri = Uri.parse('$baseUrlV2/carros/tipo/$type');

    User? user = await User.get();

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${user?.token}"
    };

    final response = await baseClient.get(carsUri, headers: headers);

    if (response.statusCode == 200) {
      List cars = jsonDecode(response.body);
      return cars.map((value) => Car.fromJson(value)).toList();
    }
    return throw HttpException("Opssss it is wrong");
  }
}
