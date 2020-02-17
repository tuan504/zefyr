// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:notus/notus.dart';

import 'editable_box.dart';

class ZefyrSubBlock extends StatelessWidget {
  ZefyrSubBlock({@required this.node}) : assert(node != null);

  final EmbedNode node;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(color: Colors.green, padding: EdgeInsets.all(8.0));
  }
}
