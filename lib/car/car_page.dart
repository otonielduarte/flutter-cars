import 'dart:async';

import 'package:cars/car/car.dart';
import 'package:cars/car/car_bloc.dart';
import 'package:cars/car/car_list_view.dart';
import 'package:cars/shared/event_bus.dart';
import 'package:cars/shared/widget/app_text.dart';
import 'package:cars/shared/widget/loading.dart';
import 'package:cars/shared/widget/text_error.dart';
import 'package:flutter/material.dart';

class CarsPage extends StatefulWidget {
  final String type;
  const CarsPage(this.type);

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage>
    with AutomaticKeepAliveClientMixin<CarsPage> {
  late StreamSubscription<Event> subscription;

  @override
  bool get wantKeepAlive => true;

  final _bloc = CarBloc();

  @override
  void initState() {
    super.initState();

    _loadData();

    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event event) {
      CarEvent carEvent = event as CarEvent;
      if (carEvent.type == widget.type) {
        _loadData();
      }
    });
  }

  Future<void> _loadData() {
    return _bloc.fetch(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: _futureBuilder(),
    );
  }

  _futureBuilder() {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: StreamBuilder<List<Car>>(
        stream: _bloc.stream,
        builder: (BuildContext context, AsyncSnapshot<List<Car>> snapshot) {
          if (snapshot.hasError) {
            return AppTextError();
          }
          if (snapshot.hasData) {
            final cars = snapshot.data;
            if (cars!.length > 0) {
              return CarsListView(cars);
            }
            return Center(
              child: AppText('No results'),
            );
          }
          return LoadingComponent();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();

    subscription.cancel();
  }
}
