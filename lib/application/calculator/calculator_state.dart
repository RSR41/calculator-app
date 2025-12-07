/// application/calculator/calculator_state.dart
///
/// 계산기 UI의 상태를 표현하는 불변(immutable) 클래스
/// Riverpod 또는 Provider에서 사용될 상태 모델입니다.

class CalculatorState {
  /// 디스플레이에 표시될 값 (결과)
  final String displayValue;

  /// 현재 수식 (예: "1 + 2")
  final String currentExpression;

  /// 에러 상태 여부
  final bool isError;

  /// 현재 숫자 입력 중인지 여부 (UI 피드백용)
  final bool isEnteringNumber;

  const CalculatorState({
    required this.displayValue,
    required this.currentExpression,
    required this.isError,
    required this.isEnteringNumber,
  });

  /// 초기 상태 팩토리 생성자
  factory CalculatorState.initial() {
    return const CalculatorState(
      displayValue: '0',
      currentExpression: '',
      isError: false,
      isEnteringNumber: false,
    );
  }

  /// 상태 복사 메서드 (불변성 유지)
  CalculatorState copyWith({
    String? displayValue,
    String? currentExpression,
    bool? isError,
    bool? isEnteringNumber,
  }) {
    return CalculatorState(
      displayValue: displayValue ?? this.displayValue,
      currentExpression: currentExpression ?? this.currentExpression,
      isError: isError ?? this.isError,
      isEnteringNumber: isEnteringNumber ?? this.isEnteringNumber,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalculatorState &&
        other.displayValue == displayValue &&
        other.currentExpression == currentExpression &&
        other.isError == isError &&
        other.isEnteringNumber == isEnteringNumber;
  }

  @override
  int get hashCode {
    return displayValue.hashCode ^ 
           currentExpression.hashCode ^ 
           isError.hashCode ^ 
           isEnteringNumber.hashCode;
  }

  @override
  String toString() {
    return 'CalculatorState(displayValue: $displayValue, currentExpression: $currentExpression, isError: $isError, isEnteringNumber: $isEnteringNumber)';
  }
}