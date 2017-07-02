import 'dart:html';

import 'constants.dart';
import 'models.dart';

class RenderingContext {
  CanvasRenderingContext2D _context;

  RenderingContext(this._context) {
    font = defaultFont;
  }

  set font(String newFont) => _context.font = newFont;

  void fillText(
    String text,
    int x,
    int y, {
    Color color: textColor,
    int maxWidth,
  }) {
    _context.setFillColorRgb(color.r, color.g, color.b);
    _context.fillText(text, x, y, maxWidth);
  }

  void fillRect(
    int x,
    int y,
    int width,
    int height, {
    Color color: rectColor,
  }) {
    _context.setFillColorRgb(color.r, color.g, color.b);
    _context.fillRect(x, y, width, height);
  }
}
