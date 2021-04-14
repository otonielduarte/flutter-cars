import 'package:cars/car/car.dart';
import 'package:cars/car/car_api.dart';
import 'package:cars/shared/widget/loading.dart';
import 'package:flutter/material.dart';

class CarsListView extends StatefulWidget {
  final String type;
  const CarsListView(this.type);

  @override
  _CarsListViewState createState() => _CarsListViewState();
}

class _CarsListViewState extends State<CarsListView>
    with AutomaticKeepAliveClientMixin<CarsListView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: _futereBuilder(),
    );
  }

  _futereBuilder() {
    return FutureBuilder(
      future: CarApi.getCarsByType(widget.type),
      initialData: [],
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return LoadingComponent();
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              final List<Car> cars = snapshot.data as List<Car>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Car car = cars[index];
                  return _itemView(car);
                },
                itemCount: cars.length,
              );
            }
            return Text(
              'Unknow Error',
            );
        }
        return Text('Unknow Error');
      },
    );
  }

  _itemView(Car car) {
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
                  onPressed: () => print('details'),
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
