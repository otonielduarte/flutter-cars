import 'package:cars/car/car.dart';
import 'package:cars/car/car_list_viw.dart';
import 'package:cars/login/nav_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carros'),
          bottom: TabBar(
            tabs: [
              Tab(text: "Clássics"),
              Tab(text: "Sport"),
              Tab(text: "Luxe"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CarsListView(CarType.classicos),
            CarsListView(CarType.esportivos),
            CarsListView(CarType.luxo),
          ],
        ),
        drawer: NavigationDrawer(),
      ),
    );
  }
}
