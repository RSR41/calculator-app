/// core/app_constants.dart
///
/// 앱 전역에서 사용되는 상수 정의
/// 레이아웃 크기, 간격, 애니메이션 등의 값을 관리합니다.

class AppConstants {
  AppConstants._(); // 인스턴스화 방지

  // ==================== 레이아웃 상수 ====================

  /// 버튼 간 간격 (iOS 계산기 스타일)
  static const double buttonSpacing = 12.0;

  /// 화면 좌우 패딩
  static const double horizontalPadding = 16.0;

  /// 디스플레이 영역 하단 패딩
  static const double displayBottomPadding = 32.0;

  /// 디스플레이 영역 좌우 패딩
  static const double displayHorizontalPadding = 32.0;

  /// 버튼 그리드 상단 패딩
  static const double buttonGridTopPadding = 24.0;

  /// 버튼 그리드 하단 패딩 (SafeArea 고려)
  static const double buttonGridBottomPadding = 24.0;

  /// 버튼 행 개수
  static const int buttonRows = 5;

  /// 버튼 열 개수
  static const int buttonColumns = 4;

  // ==================== 버튼 크기 상수 ====================

  /// 일반 버튼 크기 비율 (화면 너비 대비)
  /// 예: (화면 너비 - 패딩 - 간격) / 4
  static double getButtonSize(double screenWidth) {
    return (screenWidth - (horizontalPadding * 2) - (buttonSpacing * 3)) / 4;
  }

  /// 0 버튼의 너비 (일반 버튼의 2배 + 간격)
  static double getZeroButtonWidth(double screenWidth) {
    final buttonSize = getButtonSize(screenWidth);
    return (buttonSize * 2) + buttonSpacing;
  }

  // ==================== 애니메이션 상수 ====================

  /// 버튼 눌림 애니메이션 시간
  static const Duration buttonPressDuration = Duration(milliseconds: 100);

  /// 버튼 릴리즈 애니메이션 시간
  static const Duration buttonReleaseDuration = Duration(milliseconds: 150);

  /// 디스플레이 텍스트 변경 애니메이션 시간
  static const Duration displayChangeDuration = Duration(milliseconds: 50);

  // ==================== 입력 제한 상수 ====================

  /// 최대 입력 자릿수 (소수점 제외)
  static const int maxDigits = 12;

  /// 최대 소수점 이하 자릿수
  static const int maxDecimalPlaces = 8;

  // ==================== 디스플레이 상수 ====================

  /// 디스플레이 영역 높이 비율 (화면 전체 높이 대비)
  static const double displayHeightRatio = 0.35;

  /// 최대 디스플레이 폰트 크기
  static const double maxDisplayFontSize = 96.0;

  /// 최소 디스플레이 폰트 크기
  static const double minDisplayFontSize = 40.0;

  // ==================== 기타 상수 ====================

  /// 앱 타이틀
  static const String appTitle = 'Calculator';

  /// 에러 메시지
  static const String errorMessage = 'Error';

  /// 초기 디스플레이 값
  static const String initialDisplayValue = '0';
}