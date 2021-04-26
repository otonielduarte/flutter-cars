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
      await getHeaders(),
    );

    if (response.statusCode == 200) {
      List cars = jsonDecode(response.body);
      return cars.map((value) => Car.fromJson(value)).toList();
    }
    return throw HttpException("Opssss it is wrong");
  }

  Future<ApiResponse> save(Car car) async {
    final response = await post(
      '$baseUrlV2/carros/',
      await getHeaders(),
      car.toJson(),
    );

    if (response.ok) {
      final Car car = Car.fromJson(response.result);
      return ApiResponse.ok(car);
    }
    return response;
  }

  Future<ApiResponse> remove(int carId) async {
    final response = await delete(
      '$baseUrlV2/carros/$carId',
      await getHeaders(),
    );

    return response;
  }

  Future<ApiResponse> update(Car car) async {
    final response = await put(
      '$baseUrlV2/carros/${car.id}',
      await getHeaders(),
      car.toJson(),
    );

    if (response.ok) {
      final Car car = Car.fromJson(response.result);
      return ApiResponse.ok(car);
    }
    return response;
  }
}
