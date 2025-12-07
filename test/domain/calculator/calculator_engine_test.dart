/// test/domain/calculator/calculator_engine_test.dart
///
/// CalculatorEngine의 단위 테스트
/// 계산 로직, 엣지 케이스, 에러 처리를 검증합니다.

import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/domain/calculator/calculator_engine.dart';
import 'package:calculator_app/domain/calculator/operator.dart';

void main() {
  late CalculatorEngine engine;

  setUp(() {
    engine = CalculatorEngine();
  });

  group('기본 숫자 입력 테스트', () {
    test('초기 상태는 0이어야 함', () {
      expect(engine.displayValue, '0');
    });

    test('숫자 입력 시 디스플레이 업데이트', () {
      engine.inputDigit(5);
      expect(engine.displayValue, '5');
    });

    test('여러 숫자 입력', () {
      engine.inputDigit(1);
      engine.inputDigit(2);
      engine.inputDigit(3);
      expect(engine.displayValue, '123');
    });

    test('선행 0은 제거되어야 함', () {
      engine.inputDigit(0);
      engine.inputDigit(5);
      expect(engine.displayValue, '5');
    });

    test('최대 12자리 제한', () {
      for (int i = 0; i < 15; i++) {
        engine.inputDigit(9);
      }
      expect(engine.displayValue.replaceAll('.', '').length, lessThanOrEqualTo(12));
    });
  });

  group('소수점 입력 테스트', () {
    test('소수점 입력', () {
      engine.inputDigit(3);
      engine.inputDecimal();
      engine.inputDigit(1);
      engine.inputDigit(4);
      expect(engine.displayValue, '3.14');
    });

    test('숫자 없이 소수점만 입력하면 0.으로 시작', () {
      engine.inputDecimal();
      expect(engine.displayValue, '0.');
    });

    test('소수점은 한 번만 입력 가능', () {
      engine.inputDigit(1);
      engine.inputDecimal();
      engine.inputDigit(5);
      engine.inputDecimal(); // 무시되어야 함
      engine.inputDigit(3);
      expect(engine.displayValue, '1.53');
    });
  });

  group('사칙연산 테스트', () {
    test('덧셈: 2 + 3 = 5', () {
      engine.inputDigit(2);
      engine.inputOperator(Operator.addition);
      engine.inputDigit(3);
      engine.inputEquals();
      expect(engine.displayValue, '5');
    });

    test('뺄셈: 10 - 3 = 7', () {
      engine.inputDigit(1);
      engine.inputDigit(0);
      engine.inputOperator(Operator.subtraction);
      engine.inputDigit(3);
      engine.inputEquals();
      expect(engine.displayValue, '7');
    });

    test('곱셈: 4 × 5 = 20', () {
      engine.inputDigit(4);
      engine.inputOperator(Operator.multiplication);
      engine.inputDigit(5);
      engine.inputEquals();
      expect(engine.displayValue, '20');
    });

    test('나눗셈: 15 ÷ 3 = 5', () {
      engine.inputDigit(1);
      engine.inputDigit(5);
      engine.inputOperator(Operator.division);
      engine.inputDigit(3);
      engine.inputEquals();
      expect(engine.displayValue, '5');
    });

    test('소수 나눗셈: 10 ÷ 4 = 2.5', () {
      engine.inputDigit(1);
      engine.inputDigit(0);
      engine.inputOperator(Operator.division);
      engine.inputDigit(4);
      engine.inputEquals();
      expect(engine.displayValue, '2.5');
    });
  });

  group('즉시 실행형 연산 테스트', () {
    test('2 + 3 × 4 = 20 (즉시 실행)', () {
      engine.inputDigit(2);
      engine.inputOperator(Operator.addition);
      engine.inputDigit(3);
      engine.inputOperator(Operator.multiplication); // (2+3)=5 실행
      expect(engine.displayValue, '5');
      engine.inputDigit(4);
      engine.inputEquals(); // 5×4=20
      expect(engine.displayValue, '20');
    });

    test('10 - 2 + 5 = 13 (즉시 실행)', () {
      engine.inputDigit(1);
      engine.inputDigit(0);
      engine.inputOperator(Operator.subtraction);
      engine.inputDigit(2);
      engine.inputOperator(Operator.addition); // (10-2)=8 실행
      expect(engine.displayValue, '8');
      engine.inputDigit(5);
      engine.inputEquals(); // 8+5=13
      expect(engine.displayValue, '13');
    });
  });

  group('연속 = 버튼 테스트', () {
    test('2 + 3 = = = → 5, 8, 11', () {
      engine.inputDigit(2);
      engine.inputOperator(Operator.addition);
      engine.inputDigit(3);
      engine.inputEquals();
      expect(engine.displayValue, '5');
      
      engine.inputEquals();
      expect(engine.displayValue, '8');
      
      engine.inputEquals();
      expect(engine.displayValue, '11');
    });

    test('10 × 2 = = = → 20, 40, 80', () {
      engine.inputDigit(1);
      engine.inputDigit(0);
      engine.inputOperator(Operator.multiplication);
      engine.inputDigit(2);
      engine.inputEquals();
      expect(engine.displayValue, '20');
      
      engine.inputEquals();
      expect(engine.displayValue, '40');
      
      engine.inputEquals();
      expect(engine.displayValue, '80');
    });
  });

  group('부호 토글 테스트', () {
    test('양수를 음수로', () {
      engine.inputDigit(5);
      engine.toggleSign();
      expect(engine.displayValue, '-5');
    });

    test('음수를 양수로', () {
      engine.inputDigit(5);
      engine.toggleSign();
      engine.toggleSign();
      expect(engine.displayValue, '5');
    });

    test('0은 부호가 바뀌지 않음', () {
      engine.toggleSign();
      expect(engine.displayValue, '0');
    });
  });

  group('퍼센트 버튼 테스트', () {
    test('50% = 0.5', () {
      engine.inputDigit(5);
      engine.inputDigit(0);
      engine.inputPercent();
      expect(engine.displayValue, '0.5');
    });

    test('200% = 2', () {
      engine.inputDigit(2);
      engine.inputDigit(0);
      engine.inputDigit(0);
      engine.inputPercent();
      expect(engine.displayValue, '2');
    });
  });

  group('에러 처리 테스트', () {
    test('0으로 나누기 시 에러', () {
      engine.inputDigit(5);
      engine.inputOperator(Operator.division);
      engine.inputDigit(0);
      engine.inputEquals();
      expect(engine.displayValue, 'Error');
      expect(engine.isError, true);
    });

    test('에러 후 숫자 입력 시 새로운 계산 시작', () {
      engine.inputDigit(5);
      engine.inputOperator(Operator.division);
      engine.inputDigit(0);
      engine.inputEquals();
      expect(engine.isError, true);
      
      engine.inputDigit(3);
      expect(engine.displayValue, '3');
      expect(engine.isError, false);
    });
  });

  group('AC 버튼 테스트', () {
    test('AC는 모든 상태를 초기화', () {
      engine.inputDigit(5);
      engine.inputOperator(Operator.addition);
      engine.inputDigit(3);
      engine.clear();
      
      expect(engine.displayValue, '0');
      expect(engine.isError, false);
    });

    test('에러 상태에서 AC', () {
      engine.inputDigit(5);
      engine.inputOperator(Operator.division);
      engine.inputDigit(0);
      engine.inputEquals();
      
      engine.clear();
      expect(engine.displayValue, '0');
      expect(engine.isError, false);
    });
  });

  group('복잡한 시나리오 테스트', () {
    test('= 후 새 숫자 입력 시 새 계산 시작', () {
      engine.inputDigit(2);
      engine.inputOperator(Operator.addition);
      engine.inputDigit(3);
      engine.inputEquals();
      expect(engine.displayValue, '5');
      
      engine.inputDigit(7);
      expect(engine.displayValue, '7');
    });

    test('= 후 연산자 입력 시 이전 결과 활용', () {
      engine.inputDigit(5);
      engine.inputOperator(Operator.multiplication);
      engine.inputDigit(2);
      engine.inputEquals();
      expect(engine.displayValue, '10');
      
      engine.inputOperator(Operator.addition);
      engine.inputDigit(3);
      engine.inputEquals();
      expect(engine.displayValue, '13');
    });

    test('소수점 포함 복잡한 계산', () {
      engine.inputDigit(3);
      engine.inputDecimal();
      engine.inputDigit(1);
      engine.inputDigit(4);
      engine.inputOperator(Operator.multiplication);
      engine.inputDigit(2);
      engine.inputEquals();
      expect(double.parse(engine.displayValue), closeTo(6.28, 0.01));
    });
  });
}