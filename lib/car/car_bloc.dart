import 'package:cars/car/car.dart';
import 'package:cars/car/car_api.dart';
import 'package:cars/shared/generic_bloc.dart';

class CarBloc extends GenericBloc<List<Car>> {
  fetch(param) async {
    try {
      List<Car> cars = await CarApi.getCarsByType(param);

      add(cars);
    } catch (e) {
      addError(e);
    }
  }
}
