import 'package:client_app/widgets/data_card_link_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/dashboard_model.dart';

class DashboardNewsWidget extends StatelessWidget {
  const DashboardNewsWidget({super.key, required this.news});

  final List<News> news;

  @override
  Widget build(BuildContext context) {
    return DataCardLinkWidget(
        title: "News",
        data: news
            .map((news) => LinkContent(name: news.titulo, link: news.url))
            .toList());
  }
}
