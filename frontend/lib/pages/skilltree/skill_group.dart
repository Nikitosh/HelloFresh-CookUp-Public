import 'dart:math';

import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:simple_icons/simple_icons.dart';

class SkillGroup extends StatefulWidget {
  final String name;
  final dynamic skills;

  final dynamic data;
  final ValueNotifier<int> idx;

  const SkillGroup({
    super.key,
    required this.name,
    required this.skills,
    required this.data,
    required this.idx,
  });

  @override
  State<SkillGroup> createState() => _SkillGroupState();
}

class _SkillGroupState extends State<SkillGroup> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, child) {
        var array = widget.data.elementAt(
            (widget.idx.value + 1) % widget.data.length)[widget.name];
        array ??= [];
        return Row(children: [
          const SizedBox(width: 5),
          Container(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8), // Border width
                        decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary,
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).accent,
                            ),
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Transform.scale(
                                  scale: 0.85,
                                  child: ImageIcon(
                                    AssetImage(
                                        "assets/images/${widget.name}.png"),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 92,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ...widget.skills.keys.map(
                        (skill) => Row(children: [
                          Column(children: [
                            ClipRect(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                  SizedBox(height: 0),
                                  Transform.scale(
                                    scale: 0.92,
                                    child: Stack(
                                      children: [
                                        Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: array.contains(skill)
                                                  ? FlutterFlowTheme.of(context)
                                                      .error
                                                  : FlutterFlowTheme.of(context)
                                                      .accent,
// border: Border.all(
//     color: FlutterFlowTheme.of(context).primary,
//     width: 7)
                                            ),
                                            child: Transform.scale(
                                              scale: 0.5,
                                              child: ImageIcon(
                                                AssetImage(
                                                    "${"assets/images/" + skill}.png"),
                                                color: Colors.brown,
                                                size: 64,
                                              ),
                                            )),
                                        Positioned(
                                            left: 0,
                                            child: SizedBox(
                                              height: 80.0,
                                              width: 80.0,
                                              child: CircularProgressIndicator(
                                                value: widget.skills[skill]
                                                        .toInt() *
                                                    0.25,
                                                strokeWidth: 7,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    skill,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'Agrandir',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ]))
                          ]),
                          SizedBox(width: 5)
                        ]),
                      )
                    ],
                  )))
        ]);
      },
      valueListenable: widget.idx,
    );
  }
}
