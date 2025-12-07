/// core/app_text_styles.dart
///
/// 계산기 앱에서 사용되는 텍스트 스타일 정의
/// iOS 계산기의 타이포그래피를 재현합니다.

import 'package:flutter/material.dart';
import 'package:calculator_app/core/button_type.dart';

class AppTextStyles {
  AppTextStyles._(); // 인스턴스화 방지

  // ==================== 디스플레이 텍스트 스타일 ====================

  /// 디스플레이 텍스트 스타일 (기본)
  /// 폰트 크기는 디스플레이 영역 높이에 따라 동적으로 조정됩니다.
  static const TextStyle displayText = TextStyle(
    fontSize: 96,
    fontWeight: FontWeight.w200, // iOS 스타일의 얇은 폰트
    color: Colors.white,
    height: 1.0, // 줄 간격
    letterSpacing: -2.0, // 자간 (약간 좁게)
  );

  /// 에러 상태 디스플레이 텍스트 스타일
  static const TextStyle displayTextError = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w300,
    color: Colors.white,
    height: 1.0,
  );

  // ==================== 버튼 텍스트 스타일 ====================

  /// 숫자 버튼 텍스트 스타일
  static const TextStyle numberButton = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.0,
  );

  /// 기능 버튼 텍스트 스타일 (AC, ±, %)
  static const TextStyle functionButton = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    height: 1.0,
  );

  /// 연산자 버튼 텍스트 스타일 (+, -, ×, ÷, =)
  static const TextStyle operatorButton = TextStyle(
    fontSize: 44,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.0,
  );

  // ==================== 헬퍼 메서드 ====================

  /// 디스플레이 텍스트의 폰트 크기를 자동 조정
  /// 
  /// [text]: 표시할 텍스트
  /// [maxWidth]: 디스플레이 영역의 최대 너비
  /// [maxFontSize]: 최대 폰트 크기 (기본값: 96)
  /// [minFontSize]: 최소 폰트 크기 (기본값: 40)
  /// 
  /// Returns: 조정된 TextStyle
  static TextStyle getAdaptiveDisplayStyle({
    required String text,
    required double maxWidth,
    double maxFontSize = 96,
    double minFontSize = 40,
  }) {
    // 텍스트 길이에 따라 폰트 크기 조정
    double fontSize = maxFontSize;
    
    // 대략적인 문자 너비 계산 (폰트에 따라 다를 수 있음)
    final estimatedWidth = text.length * (fontSize * 0.6);
    
    if (estimatedWidth > maxWidth) {
      // 너무 긴 경우 폰트 크기 줄이기
      fontSize = (maxWidth / text.length) / 0.6;
      fontSize = fontSize.clamp(minFontSize, maxFontSize);
    }

    return displayText.copyWith(fontSize: fontSize);
  }

  /// 버튼 타입에 따른 텍스트 스타일 반환
  /// 
  /// [type]: 버튼 타입
  /// Returns: 해당 버튼 타입의 TextStyle
  static TextStyle getButtonTextStyle(CalculatorButtonType type) {
    switch (type) {
      case CalculatorButtonType.number:
        return numberButton;
      case CalculatorButtonType.function:
        return functionButton;
      case CalculatorButtonType.operator:
        return operatorButton;
    }
  }
}