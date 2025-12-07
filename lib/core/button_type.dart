/// core/button_type.dart
///
/// 계산기 버튼 타입을 정의하는 enum
/// 앱 전역에서 사용되며, app_colors.dart와 app_text_styles.dart에서 참조합니다.
/// 
/// 이 파일을 별도로 분리한 이유:
/// - app_colors.dart와 app_text_styles.dart에서 동일한 enum을 중복 정의하면
///   import 시 충돌이 발생할 수 있습니다.
/// - Single Source of Truth 원칙: enum은 한 곳에서만 정의되어야 합니다.
/// - 유지보수성: 버튼 타입 추가 시 한 곳만 수정하면 됩니다.

/// 계산기 버튼의 세 가지 타입을 정의
enum CalculatorButtonType {
  /// 숫자 버튼 (0-9, .)
  /// 
  /// 특징:
  /// - 회색 배경 (#333333)
  /// - 흰색 텍스트
  /// - 사용자가 숫자와 소수점을 입력할 때 사용
  number,

  /// 기능 버튼 (AC, ±, %)
  /// 
  /// 특징:
  /// - 연한 회색 배경 (#A5A5A5)
  /// - 검은색 텍스트
  /// - 계산기 상태를 변경하거나 특수 기능을 수행
  function,

  /// 연산자 버튼 (+, -, ×, ÷, =)
  /// 
  /// 특징:
  /// - 주황색 배경 (#FF9F0A) - iOS 계산기의 시그니처 컬러
  /// - 흰색 텍스트
  /// - 사칙연산 및 결과 계산에 사용
  operator,
}