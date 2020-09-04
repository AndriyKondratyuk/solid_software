import 'package:flutter/material.dart';

class AnimatedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double _preferredHeight = 56.0;
  final String title, subtitle;
  final Color textColor, uiColor;
  final Function displayPalette;

  AnimatedAppBar(
      {this.title,
      this.subtitle,
      this.textColor,
      this.uiColor,
      this.displayPalette});

  @override
  Size get preferredSize => Size.fromHeight(_preferredHeight);

  @override
  Widget build(BuildContext context) {
    double _maxTitleSize = MediaQuery.of(context).size.width - 140;
    return AnimatedContainer(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
            ),
            _title(_maxTitleSize),
            _actions(),
          ],
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          ),
        ],
        color: uiColor,
      ),
      duration: Duration(milliseconds: 200),
    );
  }

  Widget _title(double maxTitleSize) {
    return Container(
      width: maxTitleSize,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: FittedBox(
        child: Column(
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: textColor,
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actions() {
    return IconButton(
      onPressed: () {
        displayPalette();
      },
      icon: Icon(
        Icons.color_lens,
        size: 40,
      ),
      color: textColor,
    );
  }
}
