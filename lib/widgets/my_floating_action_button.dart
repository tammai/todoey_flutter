import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatefulWidget {
  const MyFloatingActionButton({
    Key? key,
    required this.onPressed,
    this.elevation = 8,
    this.highlightElevation = 0,
    this.padding = 16,
    this.color,
    this.shadowColor,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final double elevation;
  final double highlightElevation;
  final double padding;
  final Color? color;
  final Color? shadowColor;
  final Color? iconColor;
  final IconData? icon;

  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  late double _effectiveElevation;

  @override
  void initState() {
    super.initState();

    _effectiveElevation = widget.elevation;
  }

  void _onHighlightChanged(bool state) {
    _effectiveElevation = state ? widget.highlightElevation : widget.elevation;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: widget.color ?? Theme.of(context).accentColor,
      elevation: _effectiveElevation,
      shadowColor: widget.shadowColor ?? Colors.black54,
      child: InkWell(
        onTap: widget.onPressed,
        onHighlightChanged: _onHighlightChanged,
        child: Padding(
          padding: EdgeInsets.all(widget.padding),
          child: Icon(
            widget.icon,
            color: widget.iconColor ?? Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}
