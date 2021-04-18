import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cars/car/car.dart';
import 'package:cars/shared/services/api_response.dart';
import 'package:cars/shared/services/base_api.dart';

class CarApi extends BaseApi {
  Future<List<Car>> getCarsByType(String type) async {
    final response = await apiGet(
      '$baseUrlV2/carros/tipo/$type',
      await getHeader(),
    );

    if (response.statusCode == 200) {
      List cars = jsonDecode(response.body);
      return cars.map((value) => Car.fromJson(value)).toList();
    }
    return throw HttpException("Opssss it is wrong");
  }

  Future<ApiResponse<Car>> save(Car car) async {
    final response = await post(
      '$baseUrlV2/carros/',
      getHeader(),
      car.toJson(),
    );

    if (response.ok) {
      final Car car = Car.fromJson(response.result);
      return ApiResponse.ok(car);
    }
    return ApiResponse.error(response.msg);
  }
}
