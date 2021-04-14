import 'package:cars/car/car.dart';
import 'package:flutter/material.dart';

const imageNotFountUrl =
    "https://bitsofco.de/content/images/2018/12/broken-1.png";

class DetailCarPage extends StatelessWidget {
  final Car car;

  const DetailCarPage(this.car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${car.nome}"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black12,
          padding: EdgeInsets.all(16),
          child: _image(car.urlFoto ?? imageNotFountUrl, context),
        ),
      ),
    );
  }

  Image _image(String url, BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          _image(imageNotFountUrl, context),
    );
  }
}
