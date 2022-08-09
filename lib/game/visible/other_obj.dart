import 'dart:math';
import 'package:flutter/material.dart';

import 'package:gumpp/app_params.dart';

class OtherObj {
  /*
    Renders tap to play text.
   */
  void drawTapText(final Canvas _canvas) {
    //TODO: Düzeltilecek.
    final double _fontSize = AppParams.gameSize[0] * 0.1;
    final double _xCoord = AppParams.gameSize[0] * 0.5;
    final double _yCoord = AppParams.gameSize[1] * 0.5;

    final _textStyle = TextStyle(
        color: Colors.yellow.shade100,
        fontSize: _fontSize,
        fontWeight: FontWeight.w900);

    final _textSpan = TextSpan(
      text: "TAP TO PLAY",
      style: _textStyle,
    );

    final _textPainter = TextPainter(
      text: _textSpan,
      textDirection: TextDirection.ltr,
    );

    _textPainter.layout(
      minWidth: 0,
      maxWidth: AppParams.gameSize[0],
    );

    final offset = Offset(_xCoord - (_textPainter.width * 0.5),
        _yCoord - (_textPainter.height * 0.5));

    _textPainter.paint(_canvas, offset);
  }

  void drawBestScore(
    final Canvas _canvas,
    final int _bestScore,
  ) {
    final double _textOffset = drawBestText(_canvas);
    drawBestScoreOnly(_canvas, _bestScore, _textOffset);
  }

  /*
    Ekran üzerinde best score un üzerindeki best yazısını renderlar.
  */
  double drawBestText(final Canvas _canvas) {
    final double _height = AppParams.gameSize[1] * 0.05;

    final double _fontSize = _height;

    final double _xCoord = AppParams.gameSize[0] * 0.5;
    double _yCoord;
    if (AppParams.gameSize[1] * 0.1 - _fontSize * 0.5 > 50) {
      _yCoord = AppParams.gameSize[1] * 0.1;
    } else {
      //TODO: düzeltilecek??
      _yCoord = AppParams.gameSize[1] * 0.15;
    }

    final _bestStyle = TextStyle(
        color: Colors.yellow.shade100,
        fontSize: _fontSize,
        fontWeight: FontWeight.w900);

    final bestSpan = TextSpan(
      text: "BEST",
      style: _bestStyle,
    );
    final _bestPainter = TextPainter(
      text: bestSpan,
      textDirection: TextDirection.ltr,
    );
    _bestPainter.layout(
      minWidth: 0,
      maxWidth: AppParams.gameSize[0],
    );
    final _bestOffset =
        Offset(_xCoord - _bestPainter.width * 0.5, _yCoord - _fontSize * 0.5);

    _bestPainter.paint(_canvas, _bestOffset);

    return _yCoord + _fontSize * 0.5;
  }

  void drawBestScoreOnly(
    final Canvas _canvas,
    final int _bestScore,
    final double _textOffset,
  ) {
    final double _height = AppParams.gameSize[1] * 0.05;

    final double _fontSize = _height;

    final double _xCoord = AppParams.gameSize[0] * 0.5;

    final _scoreStyle = TextStyle(
        color: Colors.yellow.shade100,
        fontSize: _fontSize,
        fontWeight: FontWeight.w200);

    final _scoreSpan = TextSpan(
      text: _bestScore.toString(),
      style: _scoreStyle,
    );
    final _scorePainter = TextPainter(
      text: _scoreSpan,
      textDirection: TextDirection.ltr,
    );
    _scorePainter.layout(
      minWidth: 0,
      maxWidth: AppParams.gameSize[0],
    );
    final _scoreOffset =
        Offset(_xCoord - _scorePainter.width * 0.5, _textOffset);

    _scorePainter.paint(_canvas, _scoreOffset);
  }

  void drawScore(
    final Canvas _canvas,
    final bool _isRetry,
    final int _score,
  ) {
    final double _opacity = _isRetry ? 1 : 0.1;
    if (_isRetry) {
      final double _scoreFontSize = drawScoreOnly(_canvas, _score, _opacity);
      drawScoreText(_canvas, _scoreFontSize);
    } else {
      drawScoreOnly(_canvas, _score, _opacity);
    }
  }

  void drawScoreText(
    final Canvas _canvas,
    final double _scoreFontSize,
  ) {
    final double _fontSize = _scoreFontSize * 0.5;
    final double _xCoord = AppParams.gameSize[0] * 0.5;
    final double _yCoord = AppParams.gameSize[1] * 0.5 - _scoreFontSize;

    final _textStyle = TextStyle(
        color: Colors.yellow.shade100,
        fontSize: _fontSize,
        fontWeight: FontWeight.w700);

    final _textSpan = TextSpan(
      text: "SCORE",
      style: _textStyle,
    );
    final _textPainter = TextPainter(
      text: _textSpan,
      textDirection: TextDirection.ltr,
    );

    _textPainter.layout(
      minWidth: 0,
      maxWidth: AppParams.gameSize[0],
    );

    final _textOffset = Offset(_xCoord - _textPainter.width * 0.5, _yCoord);

    _textPainter.paint(_canvas, _textOffset);
  }

  double drawScoreOnly(
    final Canvas _canvas,
    final int _score,
    final double _opacityy,
  ) {
    final double _fontSize = AppParams.gameSize[0] * 0.2;
    final double _xCoord = AppParams.gameSize[0] * 0.5;
    final double _yCoord = AppParams.gameSize[1] * 0.5;

    final _textStyle = TextStyle(
        color: Colors.yellow.shade100.withOpacity(_opacityy),
        fontSize: _fontSize,
        fontWeight: FontWeight.w900);

    final _textSpan = TextSpan(
      text: _score.toString(),
      style: _textStyle,
    );
    final _textPainter = TextPainter(
      text: _textSpan,
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout(
      minWidth: 0,
      maxWidth: AppParams.gameSize[0],
    );
    final _textOffset = Offset(_xCoord - _textPainter.width * 0.5,
        _yCoord - _textPainter.height * 0.5);
    _textPainter.paint(_canvas, _textOffset);
    return _fontSize;
  }
}
