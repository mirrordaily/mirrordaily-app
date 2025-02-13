import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/modules/topic_list_page/topic_list_controller.dart';

class TopicListPage extends GetView<TopicListController> {
  const TopicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TopicListPage'),
      ),body: Column(children: [




    ],),
    );
  }
}
