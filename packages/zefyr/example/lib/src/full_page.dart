// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

import 'images.dart';

class ZefyrLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Ze'),
        FlutterLogo(size: 24.0),
        Text('yr'),
      ],
    );
  }
}

class FullPageEditorScreen extends StatefulWidget {
  @override
  _FullPageEditorScreenState createState() => _FullPageEditorScreenState();
}
final initDoc = r'[{"insert":"New Text 1\n"}]';
final doc =
    r'[{"insert":"Zefyr"},{"insert":"\n","attributes":{"heading":1}},{"insert":"Soft and gentle rich text editing for Flutter applications.","attributes":{"i":true}},{"insert":"\n"},{"insert":"​","attributes":{"embed":{"type":"image","source":"asset://images/breeze.jpg"}}},{"insert":"\n"},{"insert":"Photo by Hiroyuki Takeda.","attributes":{"i":true}},{"insert":"\nZefyr is currently in "},{"insert":"early preview","attributes":{"b":true}},{"insert":". If you have a feature request or found a bug, please file it at the "},{"insert":"issue tracker","attributes":{"a":"https://github.com/memspace/zefyr/issues"}},{"insert":'
    r'".\nDocumentation"},{"insert":"\n","attributes":{"heading":3}},{"insert":"Quick Start","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/quick_start.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Data Format and Document Model","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/data_and_document.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Style Attributes","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/attr'
    r'ibutes.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Heuristic Rules","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/heuristics.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"FAQ","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/faq.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Clean and modern look"},{"insert":"\n","attributes":{"heading":2}},{"insert":"Zefyr’s rich text editor is built with simplicity and fle'
    r'xibility in mind. It provides clean interface for distraction-free editing. Think Medium.com-like experience.\nMarkdown inspired semantics"},{"insert":"\n","attributes":{"heading":2}},{"insert":"Ever needed to have a heading line inside of a quote block, like this:\nI’m a Markdown heading"},{"insert":"\n","attributes":{"block":"quote","heading":3}},{"insert":"And I’m a regular paragraph"},{"insert":"\n","attributes":{"block":"quote"}},{"insert":"Code blocks"},{"insert":"\n","attributes":{"headin'
    r'g":2}},{"insert":"Of course:\nimport ‘package:flutter/material.dart’;"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"import ‘package:zefyr/zefyr.dart’;"},{"insert":"\n\n","attributes":{"block":"code"}},{"insert":"void main() {"},{"insert":"\n","attributes":{"block":"code"}},{"insert":" runApp(MyZefyrApp());"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"}"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"\n\n\n"}]';

Delta getDelta() {
  return Delta.fromJson(json.decode(doc) as List);
}

enum _Options { darkTheme }

class _FullPageEditorScreenState extends State<FullPageEditorScreen> {
 // ZefyrController _richController = ZefyrController(NotusDocument.fromJson(json.decode(doc)));
  // final ZefyrController _controller =
  //  ZefyrController(NotusDocument.fromDelta(getDelta()));
 // final FocusNode _focusNode = FocusNode();
  bool _editing = false;
 // StreamSubscription<NotusChange> _sub;
  bool _darkTheme = false;
  var richTextString = List();

  @override
  void initState() {
    super.initState();
    richTextString.add(initDoc);
  //  _sub = _richController.document.changes.listen((change) {
  //    print('${change.source}: ${change.change}');
  //  });


  }

  @override
  void dispose() {
   // _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final done = _editing
        ? IconButton(onPressed: _stopEditing, icon: Icon(Icons.save))
        : IconButton(onPressed: _startEditing, icon: Icon(Icons.edit));

    final addButton = IconButton(icon: Icon(Icons.add), onPressed: _addText);

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: ZefyrLogo(),
        actions: [
          done,
          addButton,
          PopupMenuButton<_Options>(
            itemBuilder: buildPopupMenu,
            onSelected: handlePopupItemSelected,
          )
        ],
      ),
      body: ZefyrScaffold(
        child: SingleChildScrollView(
          child: 
              Container(
                height: 1000,
                width: 500,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: richTextString.length + 1,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      
                      if (index == richTextString.length) {
                        return SizedBox(
                          height: 1500
                        );
                      } else {
                        return EditSection(
                          currentText: richTextString[index],
                          currentIndex: index,
                          key: ObjectKey(richTextString[index]),);
                      }
                      
                      // return ZefyrEditor(
                      //   controller: _richController,
                      //   focusNode: _focusNode,
                      //   mode: _editing ? ZefyrMode.edit : ZefyrMode.select,
                      //   imageDelegate: CustomImageDelegate(),
                      //   keyboardAppearance:
                      //       _darkTheme ? Brightness.dark : Brightness.light,
                      // );
                    }
                  
          ),
              ),
        ),
      ),
    );

    // if (_darkTheme) {
    //   return Theme(data: ThemeData.dark(), child: result);
    // }
    // return Theme(data: ThemeData(primarySwatch: Colors.cyan), child: result);
  }

  void handlePopupItemSelected(value) {
    if (!mounted) return;
    setState(() {
      if (value == _Options.darkTheme) {
        _darkTheme = !_darkTheme;
      }
    });
  }

  List<PopupMenuEntry<_Options>> buildPopupMenu(BuildContext context) {
    return [
      CheckedPopupMenuItem(
        value: _Options.darkTheme,
        child: Text("Dark theme"),
        checked: _darkTheme,
      ),
    ];
  }

  void _addText() {

    final addDoc = r'[{"insert":"New Text \n testing new text body testing new text body \n testing new text body testing new text body \n testing new text body testing new text body \n"}]';
    this.setState(() {
      richTextString.add(addDoc);
    });
  }

  void _startEditing() {
    setState(() {
      _editing = true;
    });
  }

  void _stopEditing() {
    setState(() {
      _editing = false;
    });
  }
}

class EditSection extends StatefulWidget {
  String currentText;
  int currentIndex;
  Key key;

  EditSection({
    this.currentText,
    this.currentIndex,
    this.key,
  }): super(key: key);

  @override 
  _EditSectionState createState() => _EditSectionState();
}

class _EditSectionState extends State<EditSection> {
ZefyrController _richController;
StreamSubscription<NotusChange> _sub;
FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    NotusDocument document =
            NotusDocument.fromJson(json.decode(widget.currentText));
        setState(() {
          _richController = ZefyrController(document);
          });
    _sub = _richController.document.changes.listen((change) {
      print('${change.source}: ${change.change}');
      this.setState(() {
        widget.currentText = jsonEncode(_richController.document);
      });
      
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZefyrEditor(
                      controller: _richController,
                      focusNode: _focusNode,
                      autofocus: false,
                      imageDelegate: null,
                      
                      //physics: ClampingScrollPhysics(),
                    );
  }
}