import 'package:creamy_field/creamy_field.dart';
import 'package:flutter/material.dart';

enum TextMode {
  normal,
  bold,
  italic,
  underline,
  // link,  <- I'm not sure what you want to have happen with this one
}

const normalStyle = TextStyle();
const boldStyle = TextStyle(fontWeight: FontWeight.bold);
const italicStyle = TextStyle(fontStyle: FontStyle.italic);
const underlineStyle = TextStyle(decoration: TextDecoration.underline);

// Helper method

class MyEditorApp extends StatefulWidget {
  @override
  _MyEditorAppState createState() => _MyEditorAppState();
}

class _MyEditorAppState extends State<MyEditorApp> {
  // Declared a regular syntax controller.
  CreamyEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = CreamyEditingController(
      syntaxHighlighter: CreamySyntaxHighlighter(
        language: LanguageType.dart,
        theme: HighlightedThemeType.defaultTheme,
      ),
      tabSize: 5,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextStyle getStyle(TextMode mode) {
    switch (mode) {
      case TextMode.bold:
        return boldStyle;
      case TextMode.italic:
        return italicStyle;
      case TextMode.underline:
        return underlineStyle;
      default:
        return normalStyle;
    }
  }

  var currentMode = TextMode.normal;
  TextStyle currentStyle = TextStyle();

  @override
  Widget build(BuildContext context) {
    // var currentMode = controller.buildTextSpan(style: TextMode.normal);
    bool _isDark = Theme.of(context).brightness == Brightness.dark;
    var _getFontStyle = controller.buildTextSpan(
      style: getStyle(currentMode),
    );
    return new Scaffold(
      backgroundColor: _isDark ? Colors.black : Colors.white,
      appBar: new AppBar(
        title: new Text("Rich Code Editor"),
        actions: <Widget>[
          FlatButton(
            child: Text('Add tab'),
            onPressed: () {
              // Adds a tab at the selection's base base-offet
              controller.addTab();
            },
          )
        ],
      ),
      body: CreamyField(
        autofocus: true,
        // Our controller should be up casted as CreamyEditingController
        // Note: Declare controller as CreamyEditingController if this fails.
        controller: controller,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration.collapsed(hintText: 'Start writing'),
        lineCountIndicatorDecoration: LineCountIndicatorDecoration(
          backgroundColor: Colors.grey,
        ),
        style: TextStyle().merge(getStyle(currentMode)),
        maxLines: null,
        // Shows line indicator column adjacent to this widget
        showLineIndicator: true,
        // Allow this Text field to be horizontally scrollable
        horizontallyScrollable: true,
        // Additional options for text selection widget
        toolbarOptions: CreamyToolbarOptions.allTrue(
          // Below line enables dark mode in selection widget
          selectionToolbarThemeMode: ThemeMode.dark,
          useCamelCaseLabel: true,
          actions: [
            CreamyToolbarItem(
              label: 'Bold',
              callback: () {
                setState(() {
                  currentMode = TextMode.bold;
                  // currentStyle = controller.buildTextSpan(style: TextStyle());
                });
              },
            ),
            CreamyToolbarItem(
              label: 'Italic',
              callback: () {
                setState(() {
                  currentMode = TextMode.italic;
                });
              },
            ),
            CreamyToolbarItem(
              label: 'Underline',
              callback: () {
                TextStyle underline =
                    TextStyle(decoration: TextDecoration.underline);
                return editHighlightedText(underline);
                // setState(() {
                //   currentMode = TextMode.underline;
                // });
              },
            ),
          ],
        ),
      ),
    );
  }

  editHighlightedText(TextStyle style) {
    return controller.buildTextSpan(
      style: style,
    );
  }
}
