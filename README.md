# 🧮 Flutter Calculator App

iOS 기본 계산기를 재현한 고품질 Flutter 앱입니다.

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![Riverpod](https://img.shields.io/badge/Riverpod-2.4+-00ADD8)
![iOS](https://img.shields.io/badge/iOS-14.0+-000000?logo=apple)
![License](https://img.shields.io/badge/License-MIT-green)

</div>

---

## ✨ 주요 특징

### 📱 iOS 네이티브 경험
- **픽셀 퍼펙트 디자인**: iOS 계산기의 정확한 컬러, 타이포그래피 재현
- **부드러운 애니메이션**: 버튼 탭 시 스케일 애니메이션 (95% 축소)
- **햅틱 피드백**: 모든 버튼에 `lightImpact` 적용
- **반응형 폰트**: 텍스트 길이에 따라 자동 크기 조정

### 🧠 똑똑한 계산 로직
- **즉시 실행형 연산**: `2 + 3 × 4 =` → `(2+3) × 4 = 20`
- **연속 = 기능**: `2 + 3 = = =` → `5, 8, 11` (마지막 연산 반복)
- **0으로 나누기 처리**: 에러 표시 후 자동 복구
- **정밀한 소수점 처리**: 최대 8자리까지 표시

### 🏗️ 견고한 아키텍처
- **Clean Architecture**: Domain / Application / Presentation 레이어 분리
- **테스트 커버리지**: 30개 단위 테스트 포함
- **상태 관리**: Riverpod으로 안정적인 상태 관리
- **타입 세이프**: Dart의 강력한 타입 시스템 활용

---

## 📸 스크린샷

```
준비 중...
```

---

## 🚀 시작하기

### 필수 요구사항

- **Flutter SDK**: 3.0.0 이상
- **Dart SDK**: 3.0.0 이상
- **iOS Simulator** 또는 **Android Emulator** (또는 실제 기기)

### 설치 방법

1. **저장소 클론**
```bash
git clone https://github.com/your-username/calculator_app.git
cd calculator_app
```

2. **의존성 설치**
```bash
flutter pub get
```

3. **앱 실행**
```bash
flutter run
```

4. **테스트 실행**
```bash
flutter test
```

---

## 📁 프로젝트 구조

```
calculator_app/
├── lib/
│   ├── main.dart                          # 앱 진입점
│   ├── core/                              # 공통 리소스
│   │   ├── button_type.dart              # 버튼 타입 enum
│   │   ├── app_colors.dart               # iOS 컬러 팔레트
│   │   ├── app_text_styles.dart          # 타이포그래피
│   │   └── app_constants.dart            # 전역 상수
│   ├── domain/                            # 비즈니스 로직
│   │   └── calculator/
│   │       ├── operator.dart             # 연산자 정의
│   │       └── calculator_engine.dart    # 계산 엔진 (순수 Dart)
│   ├── application/                       # 상태 관리
│   │   └── calculator/
│   │       ├── calculator_state.dart     # 불변 상태 모델
│   │       └── calculator_notifier.dart  # Riverpod Notifier
│   └── presentation/                      # UI 레이어
│       └── calculator/
│           ├── calculator_page.dart      # 메인 화면
│           └── calculator_button.dart    # 버튼 위젯
├── test/
│   └── domain/
│       └── calculator/
│           └── calculator_engine_test.dart  # 단위 테스트
├── docs/
│   ├── calculator_requirements.md        # 요구사항 문서
│   └── code_sources.md                   # 코드 작성 이력
└── pubspec.yaml                          # 의존성 관리
```

---

## 🎮 사용 방법

### 기본 연산
```
입력: 5 + 3 =
결과: 8
```

### 즉시 실행형 연산
```
입력: 2 + 3 × 4 =
동작:
  1. 2 + 3 → 5 (즉시 계산)
  2. 5 × 4 → 20
결과: 20
```

### 연속 = 입력
```
입력: 2 + 3 = = =
결과: 5 → 8 → 11
(마지막 연산 +3을 반복)
```

### 부호 토글
```
입력: 5 → ± → -5 → ± → 5
```

### 백분율
```
입력: 50 → % → 0.5
입력: 200 → % → 2
```

### 0으로 나누기
```
입력: 5 ÷ 0 =
결과: Error
(이후 숫자 입력 시 자동으로 새 계산 시작)
```

---

## 🧪 테스트

### 단위 테스트 실행
```bash
flutter test
```

### 테스트 커버리지 확인
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### 테스트 케이스 (30개)
- ✅ 기본 숫자 입력 (6개)
- ✅ 소수점 처리 (3개)
- ✅ 사칙연산 (5개)
- ✅ 즉시 실행형 연산 (2개)
- ✅ 연속 = 입력 (2개)
- ✅ 부호 토글 (3개)
- ✅ 퍼센트 (2개)
- ✅ 에러 처리 (2개)
- ✅ AC 버튼 (2개)
- ✅ 복잡한 시나리오 (3개)

---

## 🛠️ 기술 스택

### 프레임워크 & 라이브러리
- **Flutter**: 3.0+ (크로스 플랫폼 UI 프레임워크)
- **Dart**: 3.0+ (프로그래밍 언어)
- **Riverpod**: 2.4+ (상태 관리)

### 개발 도구
- **flutter_lints**: 3.0+ (코드 품질)
- **flutter_test**: 단위 테스트

### 아키텍처 패턴
- **Clean Architecture**: 레이어 분리
- **MVVM**: Model-View-ViewModel
- **Repository Pattern**: 데이터 추상화 (향후 확장용)

---

## 📚 문서

- [요구사항 문서](docs/calculator_requirements.md) - 전체 기능 명세
- [코드 작성 이력](docs/code_sources.md) - 파일별 작성 정보
- [Riverpod 공식 문서](https://riverpod.dev) - 상태 관리 가이드
- [Flutter 공식 문서](https://flutter.dev) - Flutter 학습 자료

---

## 🐛 알려진 이슈

현재 알려진 이슈가 없습니다. 🎉

버그를 발견하셨다면 [Issues](https://github.com/your-username/calculator_app/issues)에 제보해주세요.

---

## 🗺️ 로드맵

### Phase 1: MVP ✅ (완료)
- [x] 기본 사칙연산
- [x] 즉시 실행형 연산
- [x] 연속 = 기능
- [x] 에러 처리
- [x] iOS 스타일 UI
- [x] 단위 테스트

### Phase 2: 개선 (예정)
- [ ] C 버튼 추가 (현재 입력만 지우기)
- [ ] 다크 모드 완전 지원
- [ ] 가로 모드 지원
- [ ] Widget 테스트 추가
- [ ] Integration 테스트 추가

### Phase 3: 확장 (미래)
- [ ] 과학 계산기 모드
- [ ] 계산 히스토리
- [ ] 커스텀 테마
- [ ] 다국어 지원
- [ ] 접근성 개선 (VoiceOver 등)

---

## 🤝 기여하기

기여는 언제나 환영합니다! 다음 단계를 따라주세요:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### 기여 가이드라인
- 코드는 `flutter analyze` 통과 필수
- 새로운 기능에는 테스트 추가
- 커밋 메시지는 명확하게 작성
- Clean Architecture 원칙 준수

---

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참고하세요.

---

## 👏 감사의 말

- **Apple**: iOS 계산기 디자인 영감
- **Riverpod**: 훌륭한 상태 관리 라이브러리
- **Flutter 커뮤니티**: 지속적인 지원과 피드백

---

## 📞 연락처

프로젝트 관련 문의:
- **GitHub Issues**: [Issues 페이지](https://github.com/your-username/calculator_app/issues)
- **Email**: your-email@example.com

---

<div align="center">

**⭐ 이 프로젝트가 도움이 되었다면 Star를 눌러주세요! ⭐**

Made with ❤️ by Claude (Anthropic)

</div>