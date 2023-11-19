import 'dart:ffi';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/utils.dart';
import 'dart:convert';
import '/main.dart';
import 'package:tuple/tuple.dart';
import 'dart:developer';

import 'carousel_model.dart';
export 'carousel_model.dart';

class CarouselWidget extends StatefulWidget {
  final dynamic recipes;
  final ValueChanged<dynamic> callback;
  final ValueChanged<dynamic> callbackButton;

  const CarouselWidget(
      {super.key,
      required this.recipes,
      required this.callback,
      required this.callbackButton});

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late CarouselModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarouselModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }
    List<ClipRRect> items = [];
    List<String> names = [];
    List<dynamic> skills = [];
    Map<String, dynamic> mymap = Map();
    widget.recipes.forEach((key, value) => {mymap[key] = value});
    List<String> keys = [];
    widget.recipes.forEach((key, value) => {keys.add(key)});
    keys.sort((e1, e2) {
      int a =
          mymap[e1]["skills_distance"].compareTo(mymap[e2]["skills_distance"]);
      if (a != 0) return a;
      int b = mymap[e1]["ingr_distance"].compareTo(mymap[e2]["ingr_distance"]);
      return b;
    });
    keys.forEach((key) => {
          items.add(
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset("assets/images/" + mymap[key]["photo"])),
          ),
          skills.add(mymap[key]["skills"]),
          names.add(key)
        });
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 180,
          child: CarouselSlider(
            items: items,
            carouselController: _model.carouselController ??=
                CarouselController(),
            options: CarouselOptions(
              initialPage: 1,
              viewportFraction: 0.5,
              disableCenter: true,
              enlargeCenterPage: true,
              enlargeFactor: 0.4,
              enableInfiniteScroll: true,
              scrollDirection: Axis.horizontal,
              autoPlay: false,
              onPageChanged: (index, _) async {
                _model.carouselCurrentIndex = index;
                setState(() {});
                widget.callback(_model.carouselCurrentIndex - 1);
                // context.pushNamed('Carousel');
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          names.elementAt(_model.carouselCurrentIndex).toString(),
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
        SizedBox(height: 10),
        FFButtonWidget(
          onPressed: () async {
            widget.callbackButton("");
            postWith(
              'update_skills/${MyApp.of(context).getId()}',
              jsonEncode(skills[_model.carouselCurrentIndex]),
            );
          },
          text: 'Cook',
          options: FFButtonOptions(
            height: 40,
            width: 95,
            // padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            // iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: FlutterFlowTheme.of(context).primary,
            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                ),
            elevation: 3,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
