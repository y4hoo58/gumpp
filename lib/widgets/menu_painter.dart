import 'package:flutter/material.dart';

import 'package:gumpp/components/game_constants.dart';

class MenuPainterr extends StatefulWidget {
  @override
  MenuPainterrState createState() => MenuPainterrState();
}

class MenuPainterrState extends State<MenuPainterr>
    with TickerProviderStateMixin {
  final List<double> stick_xs = [0.3, 0.75, 0.3, 0.85, 0.5, 0.2];
  final List<double> stick_ys = [2, 6, 8, 13, 15, 18, 19];

  Animation<double> animation;
  AnimationController controller;

  final Tween<double> _moving_path = Tween(begin: 0.95, end: 0.05);

  MenuPainterrState();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    animation = _moving_path.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.duration = Duration(milliseconds: 600);

          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.duration = Duration(milliseconds: 400);
          controller.forward();
        }
      });

    //Used to start the animation
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: MenuPainter(
          animation.value,
          stick_xs,
          stick_ys,
        ),
      ),
    );
  }
}

class MenuPainter extends CustomPainter {
  List<double> stick_xs = [];
  List<double> stick_ys = [];
  double center_y;
  MenuPainter(this.center_y, this.stick_xs, this.stick_ys);

  void move_char(Canvas canvas, Size size, double width) {
    //TODO: width parametresini hiç kullanmamışsın sanki???
    double radius = size.width * 0.05;
    double render_x = 0.2 * size.width;
    double render_y = (0.65 + (center_y * center_y * 0.25)) * size.height;

    final center = Offset(render_x, render_y);
    final paint = Paint();
    paint.color = Colors.yellow.shade100;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width * stick_width_fac;
    double height = size.height * stick_height_fac;

    move_char(canvas, size, width);

    for (var i = 0; i < stick_xs.length; i++) {
      final stick_paint = Paint();

      double render_x = stick_xs[i] * size.width - width * 0.5;
      double render_y = stick_ys[i] * size.height * 0.05 - height * 0.5;

      if (stick_ys[i] > 5 && stick_ys[i] < 7) {
        stick_paint.color = Colors.greenAccent.shade400;
      } else if (stick_ys[i] > 7 && stick_ys[i] < 10) {
        stick_paint.color = Colors.pink;
      } else if (stick_ys[i] > 14 && stick_ys[i] < 18) {
        stick_paint.color = Colors.red;
      } else {
        stick_paint.color = Colors.cyanAccent.shade100;
      }

      Rect stick_rect = Rect.fromLTWH(render_x, render_y, width, height);
      canvas.drawRect(stick_rect, stick_paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
