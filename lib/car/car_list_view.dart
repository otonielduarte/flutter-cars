import 'package:cars/car/car.dart';
import 'package:cars/car/car_bloc.dart';
import 'package:cars/car/details_car_page.dart';
import 'package:cars/shared/util/nav.dart';
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

  final _bloc = CarBloc();

  @override
  void initState() {
    super.initState();

    _bloc.fetch(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: _futureBuilder(),
    );
  }

  _futureBuilder() {
    return StreamBuilder<List<Car>>(
      stream: _bloc.stream,
      initialData: [],
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text('No results'),
            );
          case ConnectionState.waiting:
            return LoadingComponent();
          case ConnectionState.active:
            if (snapshot.hasError) {
              return Center(
                child: Text('List cars not found'),
              );
            }
            final cars = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Car car = cars![index];
                return _itemView(car);
              },
              itemCount: cars!.length,
            );
          case ConnectionState.done:
            break;
        }

        return Text(
          'Unknow Error',
        );
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

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}