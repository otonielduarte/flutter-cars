import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:cars/car/car.dart';
import 'package:cars/car/details_car_page.dart';
import 'package:cars/shared/util/nav.dart';

class CarsListView extends StatelessWidget {
  final List<Car> cars;

  CarsListView(List<Car> cars) : cars = cars;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (listViewContext, index) {
        final Car car = cars[index];
        return Container(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          height: 280,
          child: Card(
            child: InkWell(
              onTap: () => _onClickCar(listViewContext, car),
              onLongPress: () => _onLongClickCar(listViewContext, car),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: _image(car.urlFoto ?? ''),
                  ),
                  ListTile(
                    title: Text(
                      car.nome ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      car.desc ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => _onClickCar(context, car),
                        child: Text('Detalhes'),
                      ),
                      TextButton(
                        onPressed: () => _onClickShare(context, car),
                        child: Text('Share'),
                      ),
                    ],
                  )
                  // Text(car.nome),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _image(String url) {
    return CachedNetworkImage(
        width: 150,
        height: 120,
        imageUrl: url,
        errorWidget: (context, url, error) => Icon(Icons.error));
  }

  _onClickCar(BuildContext context, Car car) {
    push(context, DetailCarPage(car));
  }

  _onLongClickCar(BuildContext context, Car car) {
    showModalBottomSheet(
      context: context,
      builder: (dialogContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '${car.nome}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text("Detalhes"),
              onTap: () {
                Navigator.pop(dialogContext);
                _onClickCar(context, car);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              onTap: () {
                _onClickShare(context, car);
                Navigator.pop(dialogContext);
              },
              title: Text("Share"),
            ),
          ],
        );
      },
    );
  }

  _onClickShare(BuildContext context, Car car) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        "Project Cars - Flutter ${car.nome} modelo ${car.tipo} acertos",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
