import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'allergies_model.dart';
import '/utils.dart';
import '/main.dart';
import 'dart:developer';
export 'allergies_model.dart';

class AllergiesWidget extends StatefulWidget {
  const AllergiesWidget({Key? key}) : super(key: key);

  @override
  _AllergiesWidgetState createState() => _AllergiesWidgetState();
}

class _AllergiesWidgetState extends State<AllergiesWidget> {
  late AllergiesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllergiesModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {});
    });
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

    List<Widget> children = [
      Theme(
        data: ThemeData(),
        child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 10.0),
            child: Text(
              'Choose your dietary restrictions:',
              style: FlutterFlowTheme.of(context).displaySmall.override(
                    fontFamily: 'Agrandir',
                    fontWeight: FontWeight.w600,
                    fontSize: 36.0,
                    useGoogleFonts: false,
                  ),
            )),
      ),
    ];
    _model.allergies.forEach((key, value) => children.add(
          Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                visualDensity: VisualDensity.standard,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 0.0),
              child: CheckboxListTile(
                value: value,
                onChanged: (newValue) async {
                  setState(() => _model.allergies[key] = newValue!);
                },
                title: Text(
                  key,
                  style: FlutterFlowTheme.of(context).displaySmall.override(
                        fontFamily: 'Agrandir',
                        fontWeight: FontWeight.normal,
                        fontSize: 24.0,
                        useGoogleFonts: false,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).primaryBackground,
                activeColor: FlutterFlowTheme.of(context).primary,
                checkColor: FlutterFlowTheme.of(context).alternate,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
          ),
        ));

    children.add(Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
      child: FFButtonWidget(
        onPressed: () async {
          List<String> allergies = [];
          _model.allergies.forEach((key, value) {
            if (value) {
              allergies.add(key.split(' ').last.toLowerCase());
            }
          });
          post('allergies/${MyApp.of(context).getId()}', jsonEncode(allergies));
          context.pushNamed('tinder_skills');
        },
        text: 'Start',
        options: FFButtonOptions(
          width: double.infinity,
          height: 60.0,
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          color: FlutterFlowTheme.of(context).primary,
          textStyle: FlutterFlowTheme.of(context).titleMedium,
          elevation: 4.0,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(50.0),
          hoverColor: FlutterFlowTheme.of(context).primaryText,
        ),
      ),
    ));

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(children: [
            Column(mainAxisSize: MainAxisSize.max, children: [
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: children,
              )
            ]),
          ]),
        ),
      ),
    );
  }
}
