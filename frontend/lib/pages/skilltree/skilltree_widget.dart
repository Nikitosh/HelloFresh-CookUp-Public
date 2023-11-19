import 'package:coockup/pages/skilltree/skill_group.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/utils.dart';
import 'dart:convert';
import 'dart:developer';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'skilltree_model.dart';
export 'skilltree_model.dart';

class SkilltreeWidget extends StatefulWidget {
  final dynamic data;
  final ValueNotifier<int> idx;

  const SkilltreeWidget({super.key, required this.data, required this.idx});

  @override
  _SkilltreeWidgetState createState() => _SkilltreeWidgetState();
}

class _SkilltreeWidgetState extends State<SkilltreeWidget>
    with TickerProviderStateMixin {
  late SkilltreeModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SkilltreeModel());
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

    final scaffoldKey = GlobalKey<ScaffoldState>();
    final animationsMap = {
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: false,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          MoveEffect(
            curve: Curves.easeOut,
            delay: 0.ms,
            duration: 500.ms,
            begin: Offset(0.0, -80.0),
            end: Offset(0.0, 0.0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 100.ms,
            duration: 500.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(0.0, -80.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.ms,
            duration: 300.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.ms,
            duration: 300.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 200.ms,
            duration: 300.ms,
            begin: Offset(0.9, 0.9),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.ms,
            duration: 300.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.ms,
            duration: 300.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 300.ms,
            duration: 300.ms,
            begin: Offset(0.9, 0.9),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.ms,
            duration: 300.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.ms,
            duration: 300.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 200.ms,
            duration: 300.ms,
            begin: Offset(0.9, 0.9),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.ms,
            duration: 300.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.ms,
            duration: 300.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 300.ms,
            duration: 300.ms,
            begin: Offset(0.9, 0.9),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.ms,
            duration: 300.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.ms,
            duration: 300.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 200.ms,
            duration: 300.ms,
            begin: Offset(0.9, 0.9),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation6': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.ms,
            duration: 300.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.ms,
            duration: 300.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 300.ms,
            duration: 300.ms,
            begin: Offset(0.9, 0.9),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    };
    return FutureBuilder<dynamic>(
        future: downloadData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [CircularProgressIndicator()]),
              ],
            );
          } else {
            List<Widget> children = [];
            List<dynamic> data = [];
            Map<String, dynamic> mymap = Map();
            widget.data.forEach((key, value) => {mymap[key] = value});
            List<String> keys = [];
            widget.data.forEach((key, value) => {keys.add(key)});
            keys.sort((e1, e2) {
              int a = mymap[e1]["skills_distance"]
                  .compareTo(mymap[e2]["skills_distance"]);
              if (a != 0) return a;
              int b = mymap[e1]["ingr_distance"]
                  .compareTo(mymap[e2]["ingr_distance"]);
              return b;
            });
            keys.forEach((key) => data.add(mymap[key]["skills"]));
            snapshot.data
                .forEach((key, value) => children.add(Column(children: [
                      SkillGroup(
                              name: key,
                              skills: value,
                              data: data,
                              idx: widget.idx)
                          .animateOnPageLoad(
                              animationsMap['textOnPageLoadAnimation1']!),
                      SizedBox(height: 40),
                    ])));
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            );
          }
        });
  }

  Future<dynamic> downloadData() async {
    var q = await get('skills/${MyApp.of(context).getId()}');
    var data = jsonDecode(q);
    // log(MyApp.of(context).getId().toString());
    return Future.value(data); // return your response
  }
}
