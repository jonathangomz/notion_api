import 'dart:convert';

import 'package:flutter/material.dart' show required;
import 'package:notion_api/models/rich_text.dart';

class Page {
  final PageParent parent = PageParent();
  final PageProperties properties = PageProperties();
  final PageChildren children = PageChildren();

  Page({@required databaseId}) {
    this.parent.databaseId = databaseId;
  }

  set title(RichText value) => properties.title.add(value ?? Text(content: ''));

  Map<String, dynamic> toJson() => {
        'parent': this.parent.toJson(),
        'properties': this.properties.toJson(),
      };
}

class PageParent {
  String databaseId;

  toJson() => {
        'database_id': databaseId,
      };
}

class PageProperties {
  List<RichText> title = [];

  toJson() => {
        'title': {
          'title': title.map((e) => e.toJson()).toList(),
        },
      };
}

class PageChildren {}
