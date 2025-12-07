/// domain/calculator/operator.dart
/// 
/// 계산기에서 사용되는 연산자를 정의하는 enum 클래스
/// 사칙연산(+, -, ×, ÷)을 표현하며, 각 연산자의 심볼과 계산 로직을 포함합니다.

enum Operator {
  addition('+'),
  subtraction('−'),
  multiplication('×'),
  division('÷');

  /// 연산자 심볼 (UI 표시용)
  final String symbol;

  const Operator(this.symbol);

  /// 두 피연산자를 받아 연산을 수행하는 메서드
  /// 
  /// [left]: 왼쪽 피연산자
  /// [right]: 오른쪽 피연산자
  /// 
  /// Returns: 연산 결과
  /// Throws: [ArgumentError] 0으로 나누기 시도 시
  double calculate(double left, double right) {
    switch (this) {
      case Operator.addition:
        return left + right;
      case Operator.subtraction:
        return left - right;
      case Operator.multiplication:
        return left * right;
      case Operator.division:
        if (right == 0) {
          throw ArgumentError('Division by zero');
        }
        return left / right;
    }
  }

  /// 심볼 문자열로부터 Operator를 찾는 헬퍼 메서드
  /// 
  /// [symbol]: 연산자 심볼 문자열
  /// Returns: 해당하는 Operator 또는 null
  static Operator? fromSymbol(String symbol) {
    try {
      return Operator.values.firstWhere((op) => op.symbol == symbol);
    } catch (_) {
      return null;
    }
  }
}