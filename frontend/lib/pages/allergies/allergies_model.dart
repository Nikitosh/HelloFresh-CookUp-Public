import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'allergies_widget.dart' show AllergiesWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllergiesModel extends FlutterFlowModel<AllergiesWidget> {
  ///  Local state fields for this page.

  late Map<String, bool> allergies;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    allergies = {
      '🌱 Vegan': false,
      '🥦 Vegetarian': false,
      '🥛 Dairy-free': false,
      '🍞 Gluten-free': false,
      '🥜 Nut-free': false,
      '🐟 Fish-free': false,
      ' ☪️  Halal': false,
      ' ✡️️  Kosher': false,
    };
  }

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
