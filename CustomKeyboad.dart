import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardCustomInput extends StatefulWidget {
  const KeyboardCustomInput({Key key}) : super(key: key);

  @override
  _KeyboardCustomInputState createState() => _KeyboardCustomInputState();
}

class _KeyboardCustomInputState extends State<KeyboardCustomInput> {
  FocusNode _nodeTextField;
  TextEditingController _textEditingController;
  ScrollController _scrollController;
  double currentScroll = 0;

  void listenerField() {
    this.setState(() {});
    if (_nodeTextField.hasFocus) {
      if (_scrollController.position.pixels < 220) {
        _scrollController.animateTo(220,
            duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      }
    } else {
      // _scrollController.animateTo(currentScroll,
      //     duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    }
  }

  void listenerScroll() {
    currentScroll = _scrollController.position.extentAfter;
    // if (!_nodeTextField.hasFocus) {
    //   print(_scrollController.position.extentAfter);
    //   currentScroll = _scrollController.position.extentAfter;
    // }
  }

  @override
  void initState() {
    super.initState();

    _nodeTextField = FocusNode()..addListener(listenerField);
    _textEditingController = TextEditingController();
    _scrollController = ScrollController()..addListener(listenerScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(8.0),
              child: ListView(
                controller: _scrollController,
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  TextFormField(
                    controller: _textEditingController,
                    focusNode: _nodeTextField,
                    showCursor: true,
                    readOnly: true,
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: _nodeTextField.hasFocus ? 200 : 0,
                child: ColorPickerKeyboard(
                  onPress: (Keyboard value) {
                    String text = _textEditingController.text;

                    if (value.action == Action.CLOSE) {
                      return _nodeTextField.unfocus();
                    }

                    // Next focus
                    if (value.action == Action.NEXT) {
                      return;
                    }

                    if (value.action == Action.DELETE) {
                      if (text.isEmpty) return;

                      _textEditingController.text =
                          text.substring(0, text.length - 1);
                    }

                    if (value.action == Action.NUMBER ||
                        value.action == Action.SEMI) {
                      _textEditingController.text = text + value.title;
                    }

                    int index = _textEditingController.text.length;
                    var position =
                        TextSelection.fromPosition(TextPosition(offset: index));

                    _textEditingController.selection = position;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum Action { NUMBER, DELETE, SEMI, PERCENT, OK, NEXT, CLOSE }

class Keyboard {
  final String title;
  final Action action;

  Keyboard({this.title, this.action});
}

class ColorPickerKeyboard extends StatelessWidget {
  final Function onPress;
  ColorPickerKeyboard({Key key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    List<Keyboard> keyboard = [
      Keyboard(title: "1", action: Action.NUMBER),
      Keyboard(title: "2", action: Action.NUMBER),
      Keyboard(title: "3", action: Action.NUMBER),
      Keyboard(title: "%", action: Action.PERCENT),
      Keyboard(title: "4", action: Action.NUMBER),
      Keyboard(title: "5", action: Action.NUMBER),
      Keyboard(title: "6", action: Action.NUMBER),
      Keyboard(title: "<=", action: Action.DELETE),
      Keyboard(title: "7", action: Action.NUMBER),
      Keyboard(title: "8", action: Action.NUMBER),
      Keyboard(title: "9", action: Action.NUMBER),
      Keyboard(title: "OK", action: Action.OK),
      Keyboard(title: ",", action: Action.SEMI),
      Keyboard(title: "0", action: Action.NUMBER),
      Keyboard(title: "Close", action: Action.CLOSE),
      Keyboard(title: "Next", action: Action.NEXT),
    ];

    final int colorsPerRow = 4;
    final double itemWidth = screenWidth / colorsPerRow;
    final double itemHeight = 50;

    return Container(
      child: Wrap(
        children: <Widget>[
          for (Keyboard i in keyboard)
            GestureDetector(
              onTap: () => onPress(i),
              child: Container(
                width: itemWidth,
                height: itemHeight,
                padding: EdgeInsets.all(2),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Text(
                    i.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
