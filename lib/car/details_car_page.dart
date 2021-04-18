import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars/car/car.dart';
import 'package:cars/car/carro_form_page.dart';
import 'package:cars/car/lorem_bloc.dart';
import 'package:cars/shared/util/nav.dart';
import 'package:cars/shared/widget/app_text.dart';
import 'package:cars/shared/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const imageNotFountUrl =
    "https://bitsofco.de/content/images/2018/12/broken-1.png";

class DetailCarPage extends StatefulWidget {
  final Car car;

  DetailCarPage(this.car);

  @override
  _DetailCarPageState createState() => _DetailCarPageState();
}

class _DetailCarPageState extends State<DetailCarPage> {
  final _loremBloc = LoremBloc();

  @override
  void initState() {
    super.initState();
    _loremBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.car.nome}"),
        actions: [
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () => ('placeIcon'),
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () => ('videocam'),
          ),
          PopupMenuButton(
            onSelected: _handleMenuItem,
            itemBuilder: (builder) {
              return [
                PopupMenuItem(
                  child: Text('Edit'),
                  value: 'edit',
                ),
                PopupMenuItem(
                  child: Text('Remove'),
                  value: 'remove',
                ),
                PopupMenuItem(
                  child: Text('Share'),
                  value: 'share',
                ),
              ];
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _image(widget.car.urlFoto ?? ''),
            _line(),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 16),
              child: StreamBuilder<String>(
                stream: _loremBloc.stream,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasError) {
                    return AppText("Texto indisponivel");
                  }
                  if (snapshot.hasData) {
                    String s = snapshot.data ?? "";
                    return AppText(
                      s,
                      justify: true,
                    );
                  }
                  return LoadingComponent();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _line() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              '${widget.car.nome}',
              fontSize: 24,
              bold: true,
            ),
            AppText(
              '${widget.car.tipo}',
              fontSize: 16,
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: _onClickFavorite,
              icon: Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: _onClickShare,
              icon: Icon(Icons.share),
            )
          ],
        )
      ],
    );
  }

  _image(String url) {
    return CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error));
  }

  void _onClickFavorite() {
    print('on favorite');
  }

  void _onClickShare() {
    print('on Share');
  }

  void _handleMenuItem(String value) {
    switch (value) {
      case 'edit':
        push(context, CarFormPage(widget.car));
        break;
      case 'remove':
        print('Remove !!!!');
        break;
      case 'share':
        print('Share !!!!');
        break;
    }
  }
}
