import 'package:flutter/material.dart';
import 'package:solid_software/models/app_colors.dart';
import 'package:solid_software/widgets/animated_appbar.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AppColors appColors = AppColors();
  String _primaryAppBarTitle = 'Random Color app';
  String _secondaryAppBarTitle = 'Tap on screen to change color';
  String _centerContainerText = 'Hey there';
  String _colorPaletteText = 'Background colors';

  bool isPaletteOpened = false;
  OverlayEntry paletteMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnimatedAppBar(
        title: _primaryAppBarTitle,
        subtitle: _secondaryAppBarTitle,
        textColor: appColors.textColor,
        uiColor: appColors.uiColor,
        displayPalette: displayPalette,
      ),
      body: randomBGWidget(),
    );
  }

  void displayPalette() {
    if (isPaletteOpened) {
      paletteMenu.remove();
    } else {
      paletteMenu = paletteMenuOverlay();
      Overlay.of(context).insert(paletteMenu);
    }
    isPaletteOpened = !isPaletteOpened;
  }

  OverlayEntry paletteMenuOverlay() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: 0,
        top: 85,
        child: Column(
          children: [
            Text(_colorPaletteText, style: paletteTitle()),
            Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: colorsList(colors),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  TextStyle paletteTitle() {
    return appColors.bgColor == Colors.white
        ? Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.blue, fontWeight: FontWeight.w400)
        : Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.white, fontWeight: FontWeight.w400);
  }

  List<Widget> colorsList(List<Color> _colors) {
    List<Widget> result = List();

    for (int i = 0; i < _colors.length; i++) {
      result.add(
        Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _colors[i],
            border: (_colors[i] == appColors.uiColor)
                ? Border.all(color: Colors.white, width: 3)
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0.0, 2.0),
                blurRadius: 3.0,
              ),
            ],
          ),
          child: SizedBox(
            height: 30,
            width: 30,
          ),
        ),
      );
    }
    return result;
  }

  Widget randomBGWidget() {
    return AnimatedContainer(
      color: appColors.bgColor,
      child: InkWell(
        splashColor: appColors.bgColor,
        child: Container(child: displayTextWidget(_centerContainerText)),
        onTap: () {
          setState(() {
            appColors.changeColor();
            if (isPaletteOpened) {
              paletteMenu.remove();
              isPaletteOpened = !isPaletteOpened;
            }
          });
        },
      ),
      duration: Duration(milliseconds: 400),
    );
  }

  Widget displayTextWidget(String _text) {
    return Center(
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: appColors.uiColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              offset: Offset(0.0, 2.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: Text(
          _text.toUpperCase(),
          style: TextStyle(
            color: appColors.textColor,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
