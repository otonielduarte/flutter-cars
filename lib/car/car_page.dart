import 'package:cars/car/car.dart';
import 'package:cars/car/car_bloc.dart';
import 'package:cars/car/car_list_view.dart';
import 'package:cars/shared/widget/app_text.dart';
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
  @override
  bool get wantKeepAlive => true;

  final _bloc = CarBloc();

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  _loadData() {
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
      builder: (BuildContext context, AsyncSnapshot<List<Car>> snapshot) {
        if (snapshot.hasError) {
          return AppTextError(onTap: _loadData());
        }
        if (snapshot.hasData) {
          final cars = snapshot.data;
          return CarsListView(cars!);
        }
        return Center(
          child: AppText('No results'),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
