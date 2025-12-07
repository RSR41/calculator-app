/// application/calculator/calculator_notifier.dart
///
/// 계산기 상태를 관리하는 StateNotifier (Riverpod)
/// CalculatorEngine을 사용하여 비즈니스 로직을 처리하고,
/// UI 레이어에 상태를 제공합니다.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/domain/calculator/calculator_engine.dart';
import 'package:calculator_app/domain/calculator/operator.dart';
import 'package:calculator_app/application/calculator/calculator_state.dart';

/// CalculatorNotifier Provider
final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier();
});

class CalculatorNotifier extends StateNotifier<CalculatorState> {
  late final CalculatorEngine _engine;

  CalculatorNotifier() : super(CalculatorState.initial()) {
    _engine = CalculatorEngine();
  }

  /// 상태를 엔진에서 업데이트
  void _updateState() {
    state = CalculatorState(
      displayValue: _engine.displayValue,
      currentExpression: _engine.currentExpression,
      isError: _engine.isError,
      isEnteringNumber: _engine.isEnteringNumber,
    );
  }

  /// 숫자 버튼 입력 (0-9)
  void inputDigit(int digit) {
    _engine.inputDigit(digit);
    _updateState();
  }

  /// 소수점 버튼 입력
  void inputDecimal() {
    _engine.inputDecimal();
    _updateState();
  }

  /// 연산자 버튼 입력 (+, -, ×, ÷)
  void inputOperator(Operator operator) {
    _engine.inputOperator(operator);
    _updateState();
  }

  /// = 버튼 입력
  void inputEquals() {
    _engine.inputEquals();
    _updateState();
  }

  /// +/- 버튼 입력 (부호 토글)
  void toggleSign() {
    _engine.toggleSign();
    _updateState();
  }

  /// % 버튼 입력 (백분율)
  void inputPercent() {
    _engine.inputPercent();
    _updateState();
  }

  /// AC 버튼 입력 (전체 초기화)
  void clear() {
    _engine.clear();
    _updateState();
  }
}