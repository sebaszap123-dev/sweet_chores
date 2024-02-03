import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sweet_chores/src/config/themes/sweet_chores_icons.dart';
import 'package:sweet_chores/src/core/utils/helpers.dart';

class Categories {
  bool isActive;

  /// Need to be added when create a SQL Category
  int id;
  String name;

  /// SQL Return and string but you need to parse
  Color? color;

  /// SQL Return and int but you need to parse
  IconData? iconData;
  Categories({
    this.id = 0,
    required this.name,
    this.color,
    this.iconData,
    this.isActive = true,
  });

  Categories copyWith({
    int? id,
    String? name,
    Color? color,
    IconData? iconData,
    bool? isActive,
  }) =>
      Categories(
        name: name ?? this.name,
        id: id ?? this.id,
        color: color ?? this.color,
        iconData: iconData ?? this.iconData,
        isActive: isActive ?? this.isActive,
      );

  factory Categories.fromRawJson(String str) =>
      Categories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categories.fromJson(Map<String, dynamic> json) {
    final color = json["color"] as String;
    final int? iconCodePoint = json["iconData"];
    final name = json["name"] as String;
    return Categories(
      id: json["id"],
      name: name,
      color: color.toColor(),
      iconData: iconCodePoint == null
          ? null
          : SweetChores.sweetChoresIconsList
              .firstWhere((icon) => icon.codePoint == iconCodePoint),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color?.toHex(),
        'iconData': iconData?.codePoint,
      };
}
