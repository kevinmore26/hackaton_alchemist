import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'chatbot_screen.dart'; // Importa el nuevo archivo de Chatbot
import 'services_screen.dart'; // Asegúrate de que este archivo existe
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool darkMode = false;
  bool useSides = true;
  double numberOfFeatures = 8;
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ChatbotScreen(),
    MonitorScreen(),
    const Text('Beneficios'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.robot),
            label: 'RIMAC BOT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Beneficios',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFf1063f),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool darkMode = false;
    bool useSides = true;
    double numberOfFeatures = 8;

    const ticks = [1, 2, 3, 4, 5];
    var features = [
      "feelings",
      "lifestyle",
      "body",
      "movement",
      "nutrition",
      "obesity",
      "sleep",
      "stress",
      "depression",
    ];
    var data = [
      [4.0, 3, 5, 2, 4, 3, 5, 4],
      [3.5, 4, 4, 3, 3, 4, 4, 3]
    ];

    features = features.sublist(0, numberOfFeatures.floor());
    data = data.map((graph) => graph.sublist(0, numberOfFeatures.floor())).toList();

    final List<SalesData> lineChartData = [
      SalesData(DateTime(2023, 1, 1), 850),
      SalesData(DateTime(2023, 2, 1), 680),
      SalesData(DateTime(2023, 3, 1), 740),
      SalesData(DateTime(2023, 4, 1), 420),
      SalesData(DateTime(2023, 5,1), 500)
    ];

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 300.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/flagged/photo-1556746834-cbb4a38ee593?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 250,
                  left: 80,
                  child: Text(
                    '¡Bienvenido Iván!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(20.0), // Aquí puedes ajustar el padding deseado
              child: Container(
                color: darkMode ? Colors.black : Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Aquí tu resumen del mes!',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Score Actual:',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '500', // Número del score actual, puedes cambiarlo dinámicamente
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20), // Espacio entre la nueva sección y los gráficos
                    SizedBox(
                      height: 300, // Establece un tamaño fijo para el gráfico de línea
                      child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(),
                        title: ChartTitle(text: 'Resumen de tu score.'),
                        series: <CartesianSeries>[
                          LineSeries<SalesData, DateTime>(
                            dataSource: lineChartData,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales,
                            name: 'Bienestar',
                            dataLabelSettings: const DataLabelSettings(isVisible: true),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Gráfico de Bienestar',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          Container(
                            width: 16,
                            height: 16,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Actual',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            width: 16,
                            height: 16,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Mes pasado',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 300, // Establece un tamaño fijo para el gráfico
                      child: darkMode
                          ? RadarChart.dark(
                              ticks: ticks,
                              features: features,
                              data: data,
                              reverseAxis: true,
                              useSides: useSides,
                            )
                          : RadarChart.light(
                              ticks: ticks,
                              features: features,
                              data: data,
                              reverseAxis: true,
                              useSides: useSides,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

void main() => runApp(MaterialApp(
      home: MyHomePage(),
    ));
