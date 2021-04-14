import 'package:cars/car/car.dart';
import 'package:cars/car/car_list_view.dart';
import 'package:cars/login/nav_drawer.dart';
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
    // Depois cria o TabController
    // No método build na primeira vez ele poderá estar nulo
    _tabController = TabController(length: 3, vsync: this);

    // Primeiro busca o índice nas prefs.
    int tabIdx = await Prefs.getInt("tabIdx");

    // Agora que temos o TabController e o índice da tab,
    // chama o setState para redesenhar a tela
    setState(() {
      _tabController!.index = tabIdx;
    });

    _tabController!.addListener(() {
      print('>>>>>>>>>> eventtab listener ${_tabController!.index}');
      Prefs.setInt("tabIdx", _tabController!.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: "Clássics"),
                  Tab(text: "Sport"),
                  Tab(text: "Luxe"),
                ],
              ),
      ),
      body: _tabController == null
          ? LoadingComponent(
              message: "loading tabs",
            )
          : TabBarView(
              controller: _tabController,
              children: [
                CarsListView(CarType.classicos),
                CarsListView(CarType.esportivos),
                CarsListView(CarType.luxo),
              ],
            ),
      drawer: NavigationDrawer(),
    );
  }
}
