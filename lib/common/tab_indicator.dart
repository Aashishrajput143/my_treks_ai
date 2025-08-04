import 'package:flutter/material.dart';
import 'package:vroar/common/gradient.dart';

class TabIndicators extends StatelessWidget {
  final int _numTabs;
  final int _activeIdx;
  final Color _activeColor;
  final Color _inactiveColor;
  final double _padding;
  final double _height;
  final void Function(int) onTap;

  const TabIndicators({required int numTabs, required int activeIdx, required Color activeColor, required double padding, required double height, Color inactiveColor = const Color(0x00FFFFFF), required this.onTap, super.key})
      : _numTabs = numTabs,
        _activeIdx = activeIdx,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _padding = padding,
        _height = height;

  @override
  Widget build(BuildContext context) {
    final elements = <Widget>[];

    for (var i = 0; i < _numTabs; ++i) {
      elements.add(Expanded(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _padding),
        child: InkWell(
          onTap: () => onTap(i),
          child: Container(
            decoration: BoxDecoration(border: Border(top: BorderSide(width: 5, color: i == _activeIdx ? _activeColor : _inactiveColor)), color: i == _activeIdx ? _activeColor : _inactiveColor, gradient: AppGradients.tabGradient),
          ),
        ),
      )));
    }

    return SizedBox(
      height: _height,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: elements,
      ),
    );
  }
}
