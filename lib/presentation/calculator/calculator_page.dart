/// presentation/calculator/calculator_page.dart
///
/// 계산기 메인 화면 위젯
/// 디스플레이 영역과 버튼 그리드로 구성되며,
/// CalculatorNotifier를 통해 상태를 관리합니다.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/application/calculator/calculator_notifier.dart';
import 'package:calculator_app/core/app_colors.dart';
import 'package:calculator_app/core/app_text_styles.dart';
import 'package:calculator_app/core/app_constants.dart';
import 'package:calculator_app/core/button_type.dart';
import 'package:calculator_app/domain/calculator/operator.dart';
import 'package:calculator_app/presentation/calculator/calculator_button.dart';

class CalculatorPage extends ConsumerWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorProvider);
    final notifier = ref.read(calculatorProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // 디스플레이 영역 (수식 + 결과)
            Expanded(
              flex: 35, // 화면의 35% 차지
              child: _buildDisplay(context, state.displayValue, state.currentExpression),
            ),

            // 버튼 그리드 영역
            Expanded(
              flex: 65, // 화면의 65% 차지
              child: _buildButtonGrid(context, notifier),
            ),
          ],
        ),
      ),
    );
  }

  /// 디스플레이 영역 빌드 (수식 + 결과)
  Widget _buildDisplay(BuildContext context, String displayValue, String expression) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth - (AppConstants.displayHorizontalPadding * 2);

    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.displayHorizontalPadding,
        vertical: AppConstants.displayBottomPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 수식 표시 영역 (상단, 작은 글씨)
          if (expression.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                expression,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                  height: 1.0,
                ),
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

          // 결과 표시 영역 (하단, 큰 글씨)
          AnimatedSwitcher(
            duration: AppConstants.displayChangeDuration,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Text(
              displayValue,
              key: ValueKey<String>(displayValue),
              style: AppTextStyles.getAdaptiveDisplayStyle(
                text: displayValue,
                maxWidth: maxWidth,
              ),
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  /// 버튼 그리드 빌드
  Widget _buildButtonGrid(BuildContext context, CalculatorNotifier notifier) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = AppConstants.getButtonSize(screenWidth);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.horizontalPadding,
        vertical: AppConstants.buttonGridBottomPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: 
    [
          
          // 1행: AC, ±, %, ÷
          _buildButtonRow(
            [
              _ButtonData('AC', CalculatorButtonType.function, notifier.clear),
              _ButtonData('±', CalculatorButtonType.function, notifier.toggleSign),
              _ButtonData('%', CalculatorButtonType.function, notifier.inputPercent),
              _ButtonData('÷', CalculatorButtonType.operator, () => notifier.inputOperator(Operator.division)),
              ],
        buttonSize,
      ),

      // 2행: 7, 8, 9, ×
      _buildButtonRow(
        [
          _ButtonData('7', CalculatorButtonType.number, () => notifier.inputDigit(7)),
          _ButtonData('8', CalculatorButtonType.number, () => notifier.inputDigit(8)),
          _ButtonData('9', CalculatorButtonType.number, () => notifier.inputDigit(9)),
          _ButtonData('×', CalculatorButtonType.operator, () => notifier.inputOperator(Operator.multiplication)),
        ],
        buttonSize,
      ),

      // 3행: 4, 5, 6, −
      _buildButtonRow(
        [
          _ButtonData('4', CalculatorButtonType.number, () => notifier.inputDigit(4)),
          _ButtonData('5', CalculatorButtonType.number, () => notifier.inputDigit(5)),
          _ButtonData('6', CalculatorButtonType.number, () => notifier.inputDigit(6)),
          _ButtonData('−', CalculatorButtonType.operator, () => notifier.inputOperator(Operator.subtraction)),
        ],
        buttonSize,
      ),

      // 4행: 1, 2, 3, +
      _buildButtonRow(
        [
          _ButtonData('1', CalculatorButtonType.number, () => notifier.inputDigit(1)),
          _ButtonData('2', CalculatorButtonType.number, () => notifier.inputDigit(2)),
          _ButtonData('3', CalculatorButtonType.number, () => notifier.inputDigit(3)),
          _ButtonData('+', CalculatorButtonType.operator, () => notifier.inputOperator(Operator.addition)),
        ],
        buttonSize,
      ),

      // 5행: 0 (wide), ., =
      _buildLastRow(notifier, buttonSize),
    ],
  ),
);

}
/// 일반 버튼 행 빌드
Widget _buildButtonRow(List<_ButtonData> buttons, double buttonSize) {
return Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: buttons.map((button) {
return CalculatorButton(
text: button.text,
type: button.type,
onTap: button.onTap,
size: buttonSize,
);
}).toList(),
);
}
/// 마지막 행 빌드 (0 버튼이 가로로 넓음)
Widget _buildLastRow(CalculatorNotifier notifier, double buttonSize) {
return Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
// 0 버튼 (가로 2칸)
CalculatorButton(
text: '0',
type: CalculatorButtonType.number,
onTap: () => notifier.inputDigit(0),
isWide: true,
size: buttonSize,
),
// . 버튼
    CalculatorButton(
      text: '.',
      type: CalculatorButtonType.number,
      onTap: notifier.inputDecimal,
      size: buttonSize,
    ),

    // = 버튼
    CalculatorButton(
      text: '=',
      type: CalculatorButtonType.operator,
      onTap: notifier.inputEquals,
      size: buttonSize,
    ),
  ],
);
}
}
/// 버튼 데이터를 담는 내부 헬퍼 클래스
class _ButtonData {
final String text;
final CalculatorButtonType type;
final VoidCallback onTap;
const _ButtonData(this.text, this.type, this.onTap);
}