import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/enums/apidata_type.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/draft_js_widget_factory.dart';

class DraftJsWidgetController extends GetxController {
  final DraftJsWidgetFactory _draftJsWidgetFactory = DraftJsWidgetFactory();

  Widget getWidget(ApiData? apiData) {
    return apiData != null
        ? _draftJsWidgetFactory.createWidget(apiData)
        : const SizedBox.shrink();
  }
}
