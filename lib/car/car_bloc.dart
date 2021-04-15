import 'package:cars/car/car.dart';
import 'package:cars/car/car_api.dart';
import 'package:cars/shared/generic_bloc.dart';

class CarBloc extends GenericBloc<List<Car>> {

  fetch(String type) async {
    try{
      List<Car> cars = await CarApi.getCarsByType(type);

      add(cars);
    }catch (e) {
      addError(e);
    }
  }
}