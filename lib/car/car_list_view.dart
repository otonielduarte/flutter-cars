import 'package:cars/car/car.dart';
import 'package:cars/car/details_car_page.dart';
import 'package:cars/shared/util/nav.dart';
import 'package:flutter/material.dart';

class CarsListView extends StatelessWidget {
  final List<Car> cars;

  CarsListView(List<Car> cars) : cars = cars;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _futureBuilder(),
    );
  }

  _futureBuilder() {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        final Car car = cars[index];
        return Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: _image(car.urlFoto ??
                      'https://bitsofco.de/content/images/2018/12/broken-1.png'),
                ),
                ListTile(
                  title: Text(
                    car.nome ?? 'Empty name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    car.desc ?? 'Empty description',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => push(context, DetailCarPage(car)),
                      child: Text('Detalhes'),
                    ),
                    TextButton(
                      onPressed: () => print('share'),
                      child: Text('Share'),
                    ),
                  ],
                )
                // Text(car.nome),
              ],
            ),
          ),
        );
      },
    );
  }

  Image _image(String url) {
    return Image.network(
      url,
      width: 150,
      height: 120,
      errorBuilder: (context, error, stackTrace) =>
          _image("https://bitsofco.de/content/images/2018/12/broken-1.png"),
    );
  }
}
