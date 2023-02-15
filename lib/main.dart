import 'package:flutter/material.dart';
import 'package:web_geo_app/tilesFunc.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

var mathGeo = MathGeo();
String tiles =
    "https://core-renderer-tiles.maps.yandex.net/tiles?l=map&v=23.02.12-0-b230203083000&x=316951&y=164545&z=19&scale=1&lang=ru_RU&ads=enabled";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tile search',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Tile search'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _longController = TextEditingController();
  final _latController = TextEditingController();
  final _zoomController = TextEditingController();

  @override
  void dispose() {
    _longController.dispose();
    _latController.dispose();
    _zoomController.dispose();
    super.dispose();
  }

  void _showTiles() {
    setState(() {
      print(mathGeo.tilesXY(double.parse(_longController.text),
          double.parse(_latController.text), int.parse(_zoomController.text)));
      tiles = mathGeo.tilesXY(double.parse(_longController.text),
          double.parse(_latController.text), int.parse(_zoomController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _longController,
                  decoration: InputDecoration(
                    labelText: "Широта *",
                    hintText: "Пример: 55.682640",
                    prefixIcon: Icon(Icons.maps_ugc_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ],
                ),
                TextField(
                  controller: _latController,
                  decoration: InputDecoration(
                    labelText: "Долгота *",
                    hintText: "Пример: 37.633311",
                    prefixIcon: Icon(Icons.maps_ugc_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _zoomController,
                  decoration: InputDecoration(
                    labelText: "Укажите масштаб *",
                    hintText: "По умолчанию 19",
                    prefixIcon: Icon(Icons.zoom_in_map),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 500,
                  child: FloatingActionButton(
                    onPressed: _showTiles,
                    child: Text("Найти плитку"),
                  ),
                ),
                SizedBox(height: 30),
                Image.network(tiles),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
