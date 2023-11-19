import '../skilltree/skilltree_widget.dart';
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
import 'dart:developer';

import 'carousel_widget.dart';

class CarouselWrapperWidget extends StatefulWidget {
  final ValueNotifier<int> idx;

  const CarouselWrapperWidget({super.key, required this.idx});

  @override
  _CarouselWrapperWidgetState createState() => _CarouselWrapperWidgetState();
}

class _CarouselWrapperWidgetState extends State<CarouselWrapperWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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

    return FutureBuilder<dynamic>(
        future: downloadData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("");
          } else {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                body: Column(children: [
                  Row(children: [
                    Theme(
                      data: ThemeData(),
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(30, 50.0, 30.0, 0),
                          child: Text(
                            'Our recipes',
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: 'Agrandir',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 36.0,
                                  useGoogleFonts: false,
                                ),
                          )),
                    ),
                  ]),
                  CarouselWidget(
                      recipes: snapshot.data,
                      callback: setNecessarySkills,
                      callbackButton: newState),
                  SizedBox(height: 20),
                  Expanded(
                      child: ListView(padding: EdgeInsets.zero, children: [
                    Theme(
                      data: ThemeData(),
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              30.0, 0, 30.0, 10.0),
                          child: Text(
                            'Skills',
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: 'Agrandir',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 36.0,
                                  useGoogleFonts: false,
                                ),
                          )),
                    ),
                    SkilltreeWidget(data: snapshot.data, idx: widget.idx)
                  ]))
                ]));
          }
        });
  }

  setNecessarySkills(dynamic neededSkiils) {
    widget.idx.value = neededSkiils;
  }

  newState(dynamic neededSkiils) {
    setState(() {});
  }

  Future<dynamic> downloadData() async {
    var q = await get('recipes/${MyApp.of(context).getId()}');
    var data = jsonDecode(q);
    return Future.value(data); // return your response
  }
}
