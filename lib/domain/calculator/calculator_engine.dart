/// domain/calculator/calculator_engine.dart
///
/// 계산기의 핵심 비즈니스 로직을 담당하는 순수 Dart 클래스
/// Flutter에 의존하지 않으며, 단위 테스트가 가능합니다.
/// 
/// 즉시 실행형 연산 방식 (iOS 계산기 스타일):
/// - 2 + 3 × 4 = → (2+3)=5, 5×4=20
/// - 연산자 입력 시 즉시 이전 연산 수행

import 'package:calculator_app/domain/calculator/operator.dart';

class CalculatorEngine {
  /// 현재 디스플레이에 표시될 값
  double _currentValue = 0;

  /// 이전 연산에서 사용된 값 (연산자 입력 후 저장)
  double? _previousValue;

  /// 대기 중인 연산자 (다음 연산에서 사용)
  Operator? _pendingOperator;

  /// = 버튼 연속 입력을 위한 마지막 연산자
  Operator? _lastOperator;

  /// = 버튼 연속 입력을 위한 마지막 피연산자
  double? _lastOperand;

  /// 에러 상태 여부
  bool _isError = false;

  /// 숫자 입력 중인지 여부 (소수점, 선행 0 처리용)
  bool _isEnteringNumber = false;

  /// 소수점 입력 여부
  bool _hasDecimalPoint = false;

  /// 현재 입력 중인 숫자 문자열 (디스플레이용)
  String _currentInput = '0';

  /// 연산자 입력 직후 상태 (다음 숫자 입력 시 새로 시작해야 함)
  bool _shouldResetOnNextDigit = false;

  /// 전체 수식 표시용 문자열
  String _expression = '';

  // Getters
  String get displayValue => _isError ? 'Error' : _currentInput;
  bool get isError => _isError;
  bool get isEnteringNumber => _isEnteringNumber;
  
  /// 현재 수식 반환 (UI에서 표시용)
  String get currentExpression => _expression;

  /// 숫자 버튼 입력 처리 (0-9)
  void inputDigit(int digit) {
    if (digit < 0 || digit > 9) {
      throw ArgumentError('Digit must be between 0 and 9');
    }

    // 에러 상태에서는 새로운 계산 시작
    if (_isError) {
      _reset();
    }

    // = 입력 후 숫자 입력 시 새로운 계산 시작
    if (!_isEnteringNumber && _lastOperator != null && _pendingOperator == null) {
      _reset();
    }

    // 연산자 입력 직후 첫 숫자는 새로 시작
    if (_shouldResetOnNextDigit) {
      _currentInput = '0';
      _hasDecimalPoint = false;
      _shouldResetOnNextDigit = false;
    }

    _isEnteringNumber = true;

    // 첫 입력이거나 0만 있는 경우
    if (_currentInput == '0' && !_hasDecimalPoint) {
      _currentInput = digit.toString();
    } else {
      // 최대 자릿수 제한 (소수점 제외)
      final digitsOnly = _currentInput.replaceAll('.', '').replaceAll('-', '');
      if (digitsOnly.length >= 12) {
        return; // 12자리 제한
      }
      _currentInput += digit.toString();
    }

    _currentValue = double.parse(_currentInput);
    _updateExpression();
  }

  /// 소수점 입력 처리
  void inputDecimal() {
    // 에러 상태에서는 새로운 계산 시작
    if (_isError) {
      _reset();
    }

    // = 입력 후 소수점 입력 시 새로운 계산 시작
    if (!_isEnteringNumber && _lastOperator != null && _pendingOperator == null) {
      _reset();
    }

    // 연산자 입력 직후 소수점은 새로 시작 (0.으로)
    if (_shouldResetOnNextDigit) {
      _currentInput = '0';
      _hasDecimalPoint = false;
      _shouldResetOnNextDigit = false;
    }

    _isEnteringNumber = true;

    // 이미 소수점이 있으면 무시
    if (_hasDecimalPoint) {
      return;
    }

    _hasDecimalPoint = true;
    _currentInput += '.';
    _updateExpression();
  }

  /// 연산자 입력 처리 (+, -, ×, ÷)
  void inputOperator(Operator operator) {
    if (_isError) {
      return; // 에러 상태에서는 연산자 입력 무시
    }

    // 이미 대기 중인 연산자가 있고, 숫자 입력이 완료된 경우 먼저 계산
    if (_pendingOperator != null && _previousValue != null && _isEnteringNumber) {
      _performCalculation();
      if (_isError) {
        return; // 계산 중 에러 발생 시 중단
      }
    }

    // 현재 값을 이전 값으로 저장하고 연산자 설정
    _previousValue = _currentValue;
    _pendingOperator = operator;
    _isEnteringNumber = false;
    _shouldResetOnNextDigit = true; // 다음 숫자 입력 시 새로 시작

    // = 연속 입력 관련 변수 초기화
    _lastOperator = null;
    _lastOperand = null;

    // 수식 업데이트
    _updateExpression();
  }

  /// = 버튼 입력 처리
  void inputEquals() {
    if (_isError) {
      return;
    }

    // 첫 = 입력: 대기 중인 연산자가 있으면 계산
    if (_pendingOperator != null && _previousValue != null) {
      // 마지막 연산자와 피연산자 저장 (연속 = 를 위해)
      _lastOperator = _pendingOperator;
      _lastOperand = _currentValue;

      _performCalculation();
      if (_isError) {
        return;
      }

      _pendingOperator = null;
      _previousValue = null;
    }
    // 연속 = 입력: 마지막 연산 반복
    else if (_lastOperator != null && _lastOperand != null) {
      try {
        _currentValue = _lastOperator!.calculate(_currentValue, _lastOperand!);
        _currentInput = _formatResult(_currentValue);
      } catch (e) {
        _setError();
      }
    }

    _isEnteringNumber = false;
    _hasDecimalPoint = false;
    _shouldResetOnNextDigit = false;
    
    // = 입력 후에는 수식 초기화 (결과만 표시)
    _expression = '';
  }

  /// 실제 계산을 수행하는 내부 메서드
  void _performCalculation() {
    if (_pendingOperator == null || _previousValue == null) {
      return;
    }

    try {
      _currentValue = _pendingOperator!.calculate(_previousValue!, _currentValue);
      _currentInput = _formatResult(_currentValue);
      _hasDecimalPoint = _currentInput.contains('.');
    } catch (e) {
      _setError();
    }
  }

  /// +/- 버튼: 부호 토글
  void toggleSign() {
    if (_isError) {
      return;
    }

    if (_currentValue != 0) {
      _currentValue = -_currentValue;
      _currentInput = _formatResult(_currentValue);
      _hasDecimalPoint = _currentInput.contains('.');
      _updateExpression();
    }
  }

  /// % 버튼: 백분율 변환 (현재 값 / 100)
  void inputPercent() {
    if (_isError) {
      return;
    }

    _currentValue = _currentValue / 100;
    _currentInput = _formatResult(_currentValue);
    _isEnteringNumber = false;
    _hasDecimalPoint = _currentInput.contains('.');
    _updateExpression();
  }

  /// AC (All Clear) 버튼: 모든 상태 초기화
  void clear() {
    _reset();
  }

  /// 내부 초기화 메서드
  void _reset() {
    _currentValue = 0;
    _previousValue = null;
    _pendingOperator = null;
    _lastOperator = null;
    _lastOperand = null;
    _isError = false;
    _isEnteringNumber = false;
    _hasDecimalPoint = false;
    _currentInput = '0';
    _shouldResetOnNextDigit = false;
    _expression = '';
  }

  /// 에러 상태 설정
  void _setError() {
    _isError = true;
    _currentInput = 'Error';
    _previousValue = null;
    _pendingOperator = null;
    _lastOperator = null;
    _lastOperand = null;
    _expression = '';
  }

  /// 수식 업데이트 (UI 표시용)
  void _updateExpression() {
    if (_previousValue != null && _pendingOperator != null) {
      // 이전 값 + 연산자 + 현재 입력 중인 값
      final prevStr = _formatResult(_previousValue!);
      final currentStr = _isEnteringNumber ? _currentInput : '';
      _expression = '$prevStr ${_pendingOperator!.symbol} $currentStr';
    } else if (_isEnteringNumber) {
      // 숫자만 입력 중
      _expression = _currentInput;
    } else {
      // 아무것도 없음
      _expression = '';
    }
  }

  /// 결과값을 문자열로 포맷팅
  /// 
  /// - 정수는 소수점 없이 표시 (3.0 → "3")
  /// - 소수는 불필요한 trailing zero 제거 (3.50 → "3.5")
  /// - 너무 큰 숫자나 작은 숫자는 과학적 표기법 사용
  String _formatResult(double value) {
    // 무한대 또는 NaN 체크
    if (value.isInfinite || value.isNaN) {
      throw ArgumentError('Invalid calculation result');
    }

    // 정수인 경우
    if (value == value.toInt()) {
      return value.toInt().toString();
    }

    // 소수인 경우
    String result = value.toString();

    // 너무 긴 소수는 반올림 (최대 8자리)
    if (result.contains('.')) {
      final parts = result.split('.');
      if (parts[1].length > 8) {
        result = value.toStringAsFixed(8);
        // trailing zeros 제거
        result = result.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
    }

    // 과학적 표기법이 필요한 경우 (매우 큰 수나 작은 수)
    if (value.abs() > 1e10 || (value.abs() < 1e-6 && value != 0)) {
      result = value.toStringAsExponential(6);
    }

    return result;
  }
}