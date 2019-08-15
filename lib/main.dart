import 'package:flutter/material.dart';
import 'package:sliver_twitter/app_bar_clipper.dart';
import 'package:sliver_twitter/sized_icon.dart';

void main() => runApp(MyApp());

const _appBarExpandedSize = 200.0;
const _maxExtent = _appBarExpandedSize + 20;
const _iconSize = 80.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _controller;
  double _currentExtent = _maxExtent;
  double _magnificant = 1.0;

  @override
  void initState() {
    _addListener();
    super.initState();
  }

  void _addListener() {
    _controller = ScrollController();
    _controller?.addListener(_didScrolled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            physics: ClampingScrollPhysics(),
            controller: _controller,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: Color.fromARGB(0, 0, 0, 0),
                elevation: 0.0,
                expandedHeight: _appBarExpandedSize,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  // print('constraints=' + constraints.toString());
                  final _bottom = constraints.biggest.height;
                  _currentExtent = _bottom;
                  return FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    title: Text(_bottom.toString()),
                    background: _buildBackGround(_bottom),
                  );
                }),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Stack(
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                        ),
                        Positioned(
                          left: 20,
                          top: -_iconSize / 3,
                          child: SizedIcon(
                            initSize: _iconSize,
                            magnificant: 0.66,
                            opacity: _magnificant > 0.67 ? 0.0 : 1.0,
                          ),
                        ),
                      ],
                    ),
                  ]..addAll(
                      List.generate(20, (index) => _buildListItem(index)),
                    ),
                ),
              ),
            ],
          ),
          Positioned(
            top: _currentExtent - _iconSize / 3,
            left: 20,
            child: SizedIcon(
              opacity: _magnificant > 0.66 ? 1.0 : 0.0,
              initSize: _iconSize,
              magnificant: _magnificant,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_didScrolled);
    super.dispose();
  }

  void _didScrolled() {
    _magnificant = _calcClampedPercentage(_currentExtent, 76.0, _maxExtent);
    setState(() {});
  }
}

Widget _buildBackGround(double bottom) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.green,
    ),
  );
}

Widget _buildListItem(int index) {
  return Card(
    margin: const EdgeInsets.all(8),
    child: Container(
      padding: const EdgeInsets.all(8),
      height: 60,
      child: Text("$index"),
    ),
  );
}

double _calcClampedPercentage(double x, double min, double max) {
  final _percent = (x - min) / (max - min);
  return (_percent.clamp(0.66, 1.0));
}
