import 'package:cars/car/car.dart';
import 'package:cars/car/car_page.dart';
import 'package:cars/car/car_form_page.dart';
import 'package:cars/login/nav_drawer.dart';
import 'package:cars/shared/util/nav.dart';
import 'package:cars/shared/util/prefs.dart';
import 'package:cars/shared/widget/loading.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    // Primeiro busca o índice nas prefs.
    int tabIdx = await Prefs.getInt("tabIdx");

    // Depois cria o TabController
    // No método build na primeira vez ele poderá estar nulo
    _tabController = TabController(length: 3, vsync: this);

    // Agora que temos o TabController e o índice da tab,
    // chama o setState para redesenhar a tela
    setState(() {
      _tabController!.index = tabIdx;
    });

    _tabController!.addListener(() {
      Prefs.setInt("tabIdx", _tabController!.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        bottom: _appBarBottom(),
      ),
      body: _body(),
      drawer: NavigationDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _handleAddNewCar(context),
      ),
    );
  }

  _handleAddNewCar(BuildContext context) {
    push(context, CarFormPage(null));
  }

  Widget _body() {
    return _tabController == null
        ? LoadingComponent(
            message: "loading tabs",
          )
        : TabBarView(
            controller: _tabController,
            children: [
              CarsPage(CarType.classicos),
              CarsPage(CarType.esportivos),
              CarsPage(CarType.luxo),
            ],
          );
  }

  TabBar? _appBarBottom() {
    return _tabController == null
        ? null
        : TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "Clássics"),
              Tab(text: "Sport"),
              Tab(text: "Luxe"),
            ],
          );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
