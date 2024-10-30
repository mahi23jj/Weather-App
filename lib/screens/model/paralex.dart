import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/screens/model/home_screen.dart';
import 'package:weather/service/destination.dart';

class Paralex extends StatefulWidget {
  const Paralex({super.key});

  @override
  State<Paralex> createState() => _ParalexState();
}

class _ParalexState extends State<Paralex> {
  double _padding = 24.0;
  var _spacing = 24.0;

  double _imagewidth = 230.0;
  late final ScrollController _ScrollController;
  late final double _indexfactor;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    final devicewidth =
        window.physicalSize.shortestSide / window.devicePixelRatio;
    _indexfactor = (_imagewidth + _spacing) / devicewidth;
    _scrollOffset = -_padding / devicewidth;
    super.initState();

    _ScrollController = ScrollController();
    _ScrollController.addListener(() {
      setState(() {
        _scrollOffset = ((_ScrollController.offset - _padding) / devicewidth);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _ScrollController.dispose();
  }

  Widget image(String detail, int index) {
    return Image.asset(
      detail,
      fit: BoxFit.cover,
      alignment: Alignment(-_scrollOffset + _indexfactor * index, 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: _padding),
            controller: _ScrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage(city: alldestination.data[index].name ),)),
                child: SizedBox(
                  width: _imagewidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        image(alldestination.data[index].imageUrl, index),
                         
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.white.withOpacity(0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  alldestination.data[index].name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                              '${alldestination.data[index].temp}°C',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )
                            
                              ],
                            )
                          )
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: alldestination.data.length,
            separatorBuilder: (context, index) => SizedBox(
                  width: _spacing,
                )));
  }
}
