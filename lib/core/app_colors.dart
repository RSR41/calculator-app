/// core/app_colors.dart
///
/// iOS 계산기 스타일의 컬러 팔레트 정의
/// 라이트 모드와 다크 모드를 지원합니다.

import 'package:flutter/material.dart';
import 'package:calculator_app/core/button_type.dart';

class AppColors {
  AppColors._(); // 인스턴스화 방지

  // ==================== 라이트 모드 ====================
  
  /// 배경색
  static const Color backgroundLight = Color(0xFF000000);

  /// 디스플레이 텍스트 색상
  static const Color displayTextLight = Color(0xFFFFFFFF);

  /// 숫자 버튼 배경색
  static const Color numberButtonLight = Color(0xFF333333);

  /// 숫자 버튼 텍스트 색상
  static const Color numberButtonTextLight = Color(0xFFFFFFFF);

  /// 기능 버튼 배경색 (AC, ±, %)
  static const Color functionButtonLight = Color(0xFFA5A5A5);

  /// 기능 버튼 텍스트 색상
  static const Color functionButtonTextLight = Color(0xFF000000);

  /// 연산자 버튼 배경색 (+, -, ×, ÷, =)
  static const Color operatorButtonLight = Color(0xFFFF9F0A);

  /// 연산자 버튼 텍스트 색상
  static const Color operatorButtonTextLight = Color(0xFFFFFFFF);

  /// 버튼 활성 상태 (눌렸을 때) 오버레이 색상
  static const Color buttonPressedOverlay = Color(0x33FFFFFF);

  // ==================== 다크 모드 (향후 확장용) ====================
  
  /// 다크 모드 배경색
  static const Color backgroundDark = Color(0xFF000000);

  /// 다크 모드 디스플레이 텍스트 색상
  static const Color displayTextDark = Color(0xFFFFFFFF);

  /// 다크 모드 숫자 버튼 배경색
  static const Color numberButtonDark = Color(0xFF333333);

  /// 다크 모드 숫자 버튼 텍스트 색상
  static const Color numberButtonTextDark = Color(0xFFFFFFFF);

  /// 다크 모드 기능 버튼 배경색
  static const Color functionButtonDark = Color(0xFFA5A5A5);

  /// 다크 모드 기능 버튼 텍스트 색상
  static const Color functionButtonTextDark = Color(0xFF000000);

  /// 다크 모드 연산자 버튼 배경색
  static const Color operatorButtonDark = Color(0xFFFF9F0A);

  /// 다크 모드 연산자 버튼 텍스트 색상
  static const Color operatorButtonTextDark = Color(0xFFFFFFFF);

  // ==================== 헬퍼 메서드 ====================

  /// 버튼 타입에 따른 배경색 반환
  static Color getButtonBackground(CalculatorButtonType type, {bool isDark = false}) {
    if (isDark) {
      switch (type) {
        case CalculatorButtonType.number:
          return numberButtonDark;
        case CalculatorButtonType.function:
          return functionButtonDark;
        case CalculatorButtonType.operator:
          return operatorButtonDark;
      }
    } else {
      switch (type) {
        case CalculatorButtonType.number:
          return numberButtonLight;
        case CalculatorButtonType.function:
          return functionButtonLight;
        case CalculatorButtonType.operator:
          return operatorButtonLight;
      }
    }
  }

  /// 버튼 타입에 따른 텍스트 색상 반환
  static Color getButtonTextColor(CalculatorButtonType type, {bool isDark = false}) {
    if (isDark) {
      switch (type) {
        case CalculatorButtonType.number:
          return numberButtonTextDark;
        case CalculatorButtonType.function:
          return functionButtonTextDark;
        case CalculatorButtonType.operator:
          return operatorButtonTextDark;
      }
    } else {
      switch (type) {
        case CalculatorButtonType.number:
          return numberButtonTextLight;
        case CalculatorButtonType.function:
          return functionButtonTextLight;
        case CalculatorButtonType.operator:
          return operatorButtonTextLight;
      }
    }
  }
}