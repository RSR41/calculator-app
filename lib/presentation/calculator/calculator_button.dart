/// presentation/calculator/calculator_button.dart
///
/// 계산기 버튼 위젯
/// iOS 계산기 스타일의 원형 버튼을 구현합니다.
/// 탭 애니메이션과 햅틱 피드백을 포함합니다.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculator_app/core/app_colors.dart';
import 'package:calculator_app/core/app_text_styles.dart';
import 'package:calculator_app/core/app_constants.dart';
import 'package:calculator_app/core/button_type.dart';

class CalculatorButton extends StatefulWidget {
  /// 버튼에 표시될 텍스트
  final String text;

  /// 버튼 타입 (숫자/기능/연산자)
  final CalculatorButtonType type;

  /// 버튼 탭 시 실행될 콜백
  final VoidCallback onTap;

  /// 버튼이 가로로 확장되는지 여부 (0 버튼용)
  final bool isWide;

  /// 버튼 크기
  final double size;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.type,
    required this.onTap,
    this.isWide = false,
    required this.size,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.buttonPressDuration,
      reverseDuration: AppConstants.buttonReleaseDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95, // iOS 스타일의 미묘한 스케일 효과
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _animationController.forward();

    // iOS 스타일 햅틱 피드백
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.getButtonBackground(widget.type);
    final textColor = AppColors.getButtonTextColor(widget.type);
    final textStyle = AppTextStyles.getButtonTextStyle(widget.type);

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.isWide
              ? AppConstants.getZeroButtonWidth(MediaQuery.of(context).size.width)
              : widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: _isPressed
                ? _darkenColor(backgroundColor)
                : backgroundColor,
            borderRadius: BorderRadius.circular(widget.size / 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: widget.isWide
                  ? EdgeInsets.only(left: widget.size * 0.3)
                  : EdgeInsets.zero,
              child: Text(
                widget.text,
                style: textStyle.copyWith(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 버튼이 눌렸을 때 색상을 약간 어둡게 만드는 헬퍼 함수
  Color _darkenColor(Color color) {
    return Color.fromRGBO(
      (color.red * 0.8).round(),
      (color.green * 0.8).round(),
      (color.blue * 0.8).round(),
      1.0,
    );
  }
}