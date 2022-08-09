import 'dart:math';
import 'package:flutter/material.dart';

import 'package:gumpp/app_params.dart';
import 'package:gumpp/design_params.dart';

class GameButtons {
  /*
    Buton en boy oranı 2 olarak ayarlandı.
    Butonun x ve y konumları width ve height'e ayrı ayrı bağlı olmak zorunda.
    Buton text boyutu sqrt(butonwidth**2 + butonheight **2)*0.2 olacak şekilde ayarlandı.
    Bu sayede buton boyutu değiştikçe text boyutu da buton boyutlarına bağlı olarak değişebilir.
    Butonlar ltwh yerine centerlanacak şekilde ayarlandı.
    Buton boyutu asıl olarak ekran uzunluğuna bağlıdır. Butonlar arasındaki mesafe sınır koşulu olduğu için.
    Geniş veya uzun ekranlar için henüz test edilmedi.

  */
  void drawRetryButton(final Canvas _canvas) {
    final double _xCoordText = AppParams.gameSize[0] * 0.5;
    final double _yCoordText = AppParams.gameSize[1] * 0.65;

    final double _xCoordBut = AppParams.gameSize[0] * 0.5;
    final double _yCoordBut = AppParams.gameSize[1] * 0.65;

    final double _butHeight = AppParams.gameSize[1] * 0.1;
    final double _butWidth = _butHeight * 2;

    final double _fontSize =
        pow(pow(_butWidth, 2) + pow(_butHeight, 2), 0.5) * 0.2;

    final _textStyle = TextStyle(
      color: Colors.black,
      fontSize: _fontSize,
      fontWeight: FontWeight.w900,
    );

    final _textSpan = TextSpan(
      text: "RETRY",
      style: _textStyle,
    );
    final _textPainter = TextPainter(
      text: _textSpan,
      textDirection: TextDirection.ltr,
    );

    _textPainter.layout(
      minWidth: 0,
      maxWidth: _butWidth,
    );

    final _textOffset = Offset(_xCoordText - _textPainter.width * 0.5,
        _yCoordText - _textPainter.height * 0.5);

    final _bgRect = Rect.fromCenter(
      center: Offset(
        _xCoordBut,
        _yCoordBut,
      ),
      width: _butWidth,
      height: _butHeight,
    );

    final _bgPaint = Paint();
    _bgPaint.color = DesignParams.retryButCol;

    _canvas.drawRect(_bgRect, _bgPaint);
    _textPainter.paint(_canvas, _textOffset);
  }

  /*
    Buton en boy oranı 2 olarak ayarlandı.
    Butonun x ve y konumları width ve height'e ayrı ayrı bağlı olmak zorunda.
    Buton text boyutu sqrt(butonwidth**2 + butonheight **2)*0.2 olacak şekilde ayarlandı.
    Bu sayede buton boyutu değiştikçe text boyutu da buton boyutlarına bağlı olarak değişebilir.
    Butonlar ltwh yerine centerlanacak şekilde ayarlandı.
    Geniş veya uzun ekranlar için henüz test edilmedi.
  */
  void drawMenuButton(final Canvas _canvas) {
    final double _xCoordText = AppParams.gameSize[0] * 0.5;
    final double _yCoordText = AppParams.gameSize[1] * 0.8;

    final double _xCoordBut = AppParams.gameSize[0] * 0.5;
    final double _yCoordBut = AppParams.gameSize[1] * 0.8;

    final double _butHeight = AppParams.gameSize[1] * 0.1;
    final double _butWidth = _butHeight * 2;

    final double _fontSize =
        pow(pow(_butWidth, 2) + pow(_butHeight, 2), 0.5) * 0.2;

    final _textStyle = TextStyle(
      color: Colors.black,
      fontSize: _fontSize,
      fontWeight: FontWeight.w900,
    );

    final _textSpan = TextSpan(
      text: "MENU",
      style: _textStyle,
    );
    final _textPainter = TextPainter(
      text: _textSpan,
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout(
      minWidth: 0,
      maxWidth: _butWidth,
    );

    final _textOffset = Offset(
      _xCoordText - _textPainter.width * 0.5,
      _yCoordText - _textPainter.height * 0.5,
    );

    final _bgRect = Rect.fromCenter(
      center: Offset(
        _xCoordBut,
        _yCoordBut,
      ),
      width: _butWidth,
      height: _butHeight,
    );

    final _bgPaint = Paint();
    _bgPaint.color = DesignParams.menuButCol;

    _canvas.drawRect(_bgRect, _bgPaint);
    _textPainter.paint(_canvas, _textOffset);
  }

  /*
    
  */
  void drawPauseButton(final Canvas _canvas) {
    final double _height = AppParams.gameSize[1] * 0.05;

    final double _width = _height * 0.5;

    final double _renderX = AppParams.gameSize[0] * 0.1;
    double _renderY;
    if (AppParams.gameSize[1] * 0.1 > 50) {
      _renderY = AppParams.gameSize[1] * 0.1;
    } else {
      _renderY = AppParams.gameSize[1] * 0.15;
    }

    final _bgPaint = Paint();
    _bgPaint.color = DesignParams.pauseCol;

    final _p1 = Offset(_renderX, _renderY);
    final _p2 = Offset(_renderX, _renderY + _height);

    final _paint = Paint()
      ..color = Colors.yellow.shade100
      ..strokeWidth = _width * 0.333;

    final _p3 = Offset(_renderX + _width, _renderY);
    final _p4 = Offset(_renderX + _width, _renderY + _height);

    _canvas.drawLine(_p1, _p2, _paint);
    _canvas.drawLine(_p3, _p4, _paint);
  }
}
