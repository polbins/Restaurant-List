import 'package:flutter/material.dart';
import 'package:tech_tuesday_demo/places.dart';

import 'places.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Restaurant List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Place> _list = [];

  @override
  void initState() {
    super.initState();

    listenForPlaces();
  }

  void listenForPlaces() async {
    var stream = await getPlaces(43.645950, -79.400102);
    stream.listen((place) {
      setState(() {
        _list.add(place);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return Center(
              child: PlaceWidget(
                place: _list[index],
              ),
            );
          }),
    );
  }
}

class PlaceWidget extends StatelessWidget {
  final Place place;

  const PlaceWidget({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          '${place.rating}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      title: Text('${place.name}'),
      subtitle: Text('${place.address}'),
    );
  }
}
