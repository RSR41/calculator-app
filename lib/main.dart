/// main.dart
///
/// Flutter 계산기 앱의 진입점
/// Riverpod을 사용한 상태 관리 설정 및 앱 초기화

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/presentation/calculator/calculator_page.dart';
import 'package:calculator_app/core/app_constants.dart';

void main() {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 세로 모드만 지원 (iOS 계산기와 동일)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 상태 표시줄 스타일 설정 (iOS 스타일)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    const ProviderScope(
      child: CalculatorApp(),
    ),
  );
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        // iOS 스타일 폰트 사용
        fontFamily: '.SF UI Display', // iOS 기본 폰트 (사용 가능한 경우)
      ),
      home: const CalculatorPage(),
    );
  }
}