import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import '/utils.dart';
import 'dart:convert';
import '/main.dart';
import 'dart:developer';
import 'tinderskills_model.dart';
export 'tinderskills_model.dart';

class AllergiesTinderWidget extends StatefulWidget {
  const AllergiesTinderWidget({Key? key}) : super(key: key);

  @override
  _AllergiesTinderWidgetState createState() => _AllergiesTinderWidgetState();
}

class _AllergiesTinderWidgetState extends State<AllergiesTinderWidget> {
  late AllergiesTinderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllergiesTinderModel());
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

    Future<dynamic> downloadData() async {
      var q = await get('recipes/${MyApp.of(context).getId()}');
      var data = await jsonDecode(q);
      return Future.value(data); // return your response
    }

    Card createCard(text, value) {
      return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: FlutterFlowTheme.of(context).accent,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                image: AssetImage('assets/images/${value["photo"]}'),
                width: 320,
                height: 210,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  text,
                  style: FlutterFlowTheme.of(context).displaySmall,
                )),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.swipeableStackController.triggerSwipeLeft();
                  },
                  child: Icon(
                    Icons.thumb_down,
                    color: FlutterFlowTheme.of(context).accent2,
                    size: 30,
                  ),
                ),
                SizedBox(width: 50),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.swipeableStackController.triggerSwipeRight();
                  },
                  child: Icon(
                    Icons.thumb_up,
                    color: FlutterFlowTheme.of(context).accent2,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return FutureBuilder<dynamic>(
        future: downloadData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [CircularProgressIndicator()]),
                ],
              ),
            ));
          } else {
            List<String> keys = [];
            snapshot.data.forEach((key, value) {
              keys.add(key);
            });
            keys.shuffle();
            return Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: SafeArea(
                top: true,
                child: Stack(
                  children: [
                    Theme(
                      data: ThemeData(),
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              30.0, 20.0, 30.0, 10.0),
                          child: Text(
                            'Have you cooked this recipe already?',
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
                    FlutterFlowSwipeableStack(
                      topCardHeightFraction: 0.65,
                      middleCardHeightFraction: 0.55,
                      bottomCardHeightFraction: 0.55,
                      topCardWidthFraction: 0.9,
                      middleCardWidthFraction: 0.8,
                      bottomCardWidthFraction: 0.7,
                      onSwipeFn: (index) async {
                        if (index + 1 == min(5, keys.length)) {
                          context.pushNamed('carousel_wrapper');
                        }
                      },
                      onLeftSwipe: (index) {},
                      onRightSwipe: (index) async {
                        post('update_skills/${MyApp.of(context).getId()}',
                            jsonEncode(snapshot.data[keys[index]]["skills"]));
                        post("like/${MyApp.of(context).getId()}",
                            jsonEncode({"liked": keys[index]}));
                      },
                      onUpSwipe: (index) {},
                      onDownSwipe: (index) {},
                      itemBuilder: (context, index) {
                        return createCard(
                            keys[index], snapshot.data[keys[index]]);
                      },
                      itemCount: min(5, keys.length),
                      controller: _model.swipeableStackController,
                      enableSwipeUp: false,
                      enableSwipeDown: false,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
