# 📝 Code Sources - 코드 작성 이력

이 문서는 프로젝트의 각 파일이 어떤 AI/개발자에 의해 작성되었는지 추적하는 기록입니다.

---

## 작성 이력 테이블

| 파일명 | 경로 | 작성자 | 작성일 | 버전 | 비고 |
|--------|------|--------|--------|------|------|
| `operator.dart` | `lib/domain/calculator/` | Claude (Anthropic) | 2025-12-06 | 1.0 | 연산자 enum 정의 |
| `calculator_engine.dart` | `lib/domain/calculator/` | Claude (Anthropic) | 2025-12-06 | 1.0 | 계산 엔진 비즈니스 로직 |
| `calculator_state.dart` | `lib/application/calculator/` | Claude (Anthropic) | 2025-12-06 | 1.0 | 불변 상태 모델 |
| `calculator_notifier.dart` | `lib/application/calculator/` | Claude (Anthropic) | 2025-12-06 | 1.0 | Riverpod StateNotifier |
| `button_type.dart` | `lib/core/` | Claude (Anthropic) | 2025-12-06 | 1.0 | 버튼 타입 enum (중복 제거) |
| `app_colors.dart` | `lib/core/` | Claude (Anthropic) | 2025-12-06 | 1.1 | iOS 컬러 팔레트 (수정) |
| `app_text_styles.dart` | `lib/core/` | Claude (Anthropic) | 2025-12-06 | 1.1 | 타이포그래피 (수정) |
| `app_constants.dart` | `lib/core/` | Claude (Anthropic) | 2025-12-06 | 1.0 | 앱 전역 상수 |
| `calculator_button.dart` | `lib/presentation/calculator/` | Claude (Anthropic) | 2025-12-06 | 1.1 | 버튼 위젯 (수정) |
| `calculator_page.dart` | `lib/presentation/calculator/` | Claude (Anthropic) | 2025-12-06 | 1.1 | 메인 화면 (수정) |
| `main.dart` | `lib/` | Claude (Anthropic) | 2025-12-06 | 1.0 | 앱 진입점 |
| `pubspec.yaml` | `./` | Claude (Anthropic) | 2025-12-06 | 1.0 | 의존성 관리 |
| `calculator_engine_test.dart` | `test/domain/calculator/` | Claude (Anthropic) | 2025-12-06 | 1.0 | 단위 테스트 (30개 케이스) |

---

## 수정 이력

### 2025-12-06 - 첫 번째 수정
**수정자**: Claude (Anthropic)  
**수정 이유**: enum 중복 정의 문제 해결

#### 수정된 파일:
1. **새로 추가**: `lib/core/button_type.dart`
   - `CalculatorButtonType` enum을 별도 파일로 분리
   - `app_colors.dart`와 `app_text_styles.dart`에서 중복 정의되던 enum을 한 곳으로 통합
   - Single Source of Truth 원칙 적용

2. **수정**: `lib/core/app_colors.dart` (v1.0 → v1.1)
   - enum 정의 제거
   - `button_type.dart` import 추가
   - 기능적 변화 없음

3. **수정**: `lib/core/app_text_styles.dart` (v1.0 → v1.1)
   - enum 정의 제거
   - `button_type.dart` import 추가
   - 기능적 변화 없음

4. **수정**: `lib/presentation/calculator/calculator_button.dart` (v1.0 → v1.1)
   - `button_type.dart` import 추가
   - import 경로 명확화

5. **수정**: `lib/presentation/calculator/calculator_page.dart` (v1.0 → v1.1)
   - `button_type.dart` import 추가
   - import 경로 명확화

---

## 파일 작성 통계

### 전체 현황
- **총 파일 수**: 13개
- **코드 파일**: 11개 (.dart)
- **설정 파일**: 1개 (pubspec.yaml)
- **테스트 파일**: 1개 (calculator_engine_test.dart)
- **문서 파일**: 2개 (이 문서 + calculator_requirements.md)

### 레이어별 파일 수
- **Domain Layer**: 2개
- **Application Layer**: 2개
- **Core Layer**: 4개
- **Presentation Layer**: 2개
- **기타**: 3개 (main.dart, pubspec.yaml, test)

### 작성자별 통계
| 작성자 | 파일 수 | 총 라인 수 (예상) |
|--------|---------|-------------------|
| Claude (Anthropic) | 13개 | ~1500 라인 |

---

## 코드 리뷰 체크리스트

### ✅ 완료된 검토 항목
- [x] 모든 파일에 헤더 주석 추가
- [x] enum 중복 정의 문제 해결
- [x] import 경로 일관성 확인
- [x] 네이밍 컨벤션 준수
- [x] 레이어 간 의존성 방향 확인
- [x] 단위 테스트 작성 (30개 케이스)

### 🔍 추가 검토 필요 (향후)
- [ ] Widget 테스트 추가
- [ ] Integration 테스트 추가
- [ ] 코드 커버리지 측정
- [ ] 정적 분석 (dart analyze) 실행
- [ ] 성능 프로파일링

---

## 버전 관리 정책

### 버전 번호 규칙
- **Major.Minor** 형식 사용
- **Major**: 구조적 변경, API 변경
- **Minor**: 기능 추가, 버그 수정

### 현재 버전
- **프로젝트 버전**: 1.0.0
- **대부분 파일**: v1.0 또는 v1.1

---

## 라이선스 및 저작권

### 코드 라이선스
- **라이선스**: MIT (또는 프로젝트에 맞게 선택)
- **저작권**: 프로젝트 소유자

### AI 생성 코드 고지
이 프로젝트의 모든 코드는 Anthropic의 Claude AI에 의해 생성되었습니다.
- **AI 모델**: Claude Sonnet 4.5
- **생성 날짜**: 2025년 12월 6일
- **프롬프트 제공자**: 프로젝트 기획자

---

## 추가 정보

### 코드 스타일 가이드
- **Dart**: [Effective Dart](https://dart.dev/guides/language/effective-dart)
- **Flutter**: [Flutter Style Guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
- **Linter**: `flutter_lints` 패키지 사용

### 참고 문서
- `calculator_requirements.md`: 전체 요구사항 문서
- 프로젝트 README.md (아직 생성되지 않음)

---

**문서 버전**: 1.0  
**최종 수정일**: 2025-12-06  
**관리자**: 프로젝트 팀