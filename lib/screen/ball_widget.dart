// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_magic_ball/ball_model.dart';
import 'package:surf_practice_magic_ball/screen/colors.dart';

const double _ballSize = 280;

class BallWidget extends StatefulWidget {
  const BallWidget({super.key});

  @override
  _BallWidgetState createState() => _BallWidgetState();
}

class _BallWidgetState extends State<BallWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _verticalAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2900),
    )..repeat(reverse: true);

    const double startingPosition = -70; // Вертикальное положение в начале анимации
    const double endingPosition = 70; // Вертикальное положение в конце анимации

    _verticalAnimation = Tween<double>(
      begin: startingPosition,
      end: endingPosition,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  void stopAnimation() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
  }

  // final ballModel = Provider.of<BallModel>(context, listen: false);
  @override
  Widget build(BuildContext context) {
    _controller.reset();
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Consumer<BallModel>(builder: (context, ballModel, child) {
          if (ballModel.isLoading || ballModel.isError) {
            stopAnimation();
          } else {
            startAnimation();
          }
          return Expanded(
            child: Transform.translate(
              offset: Offset(0, _verticalAnimation.value),
              child: GestureDetector(
                onTap: () {
                  startAnimation();
                  ballModel.getAnswer();
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    CustomPaint(
                      painter: EdgingPainter(),
                      size: const Size(_ballSize, _ballSize),
                    ),
                    CustomPaint(
                      painter: BgPainter(color: () {
                        if (ballModel.isError) {
                          return BallColors.errorColor;
                        } else if (ballModel.isLoading) {
                          return BallColors.textBgColor;
                        } else {
                          return BallColors.normalBgColor;
                        }
                      }()),
                      size: const Size(_ballSize, _ballSize),
                    ),
                    SizedBox(
                      height: _ballSize - 35,
                      width: _ballSize - 30,
                      child: Center(
                        child: Text(
                          ballModel.answer,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 28,
                            color: BallColors.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

class EdgingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = BallColors.edgingColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(EdgingPainter oldDelegate) => false;
}

class BgPainter extends CustomPainter {
  final Color color;
  BgPainter({
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset((size.width - 2) / 2, (size.height + 3) / 2);
    final radius = (size.width - 10) / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(BgPainter oldDelegate) => false;
}
