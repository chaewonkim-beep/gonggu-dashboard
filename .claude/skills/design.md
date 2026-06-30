# 디자인 일관성 검사 및 수정 스킬

이 스킬은 `index.html`의 디자인 일관성을 검사하고 수정합니다.

## 디자인 토큰 (절대 하드코딩 금지)

```
색상:
  --page-bg: #F0EBE5       배경
  --cream: #FFFFFF          카드 배경
  --cream2: #F7F2EC         보조 배경 (입력창, 칩 등)
  --brown: #7B5C3E          주 강조색 (헤더, 링크, 제목)
  --brown-light: #F2EAE0    브라운 연한 배경
  --orange: #F08030         보조 강조색 (버튼, 바)
  --orange-light: #FDE8D0   오렌지 연한 배경
  --yellow: #F5C842         필터 활성
  --yellow-light: #FEF4C0   필터 활성 배경
  --green: #4CAF50          긍정/완료
  --green-light: #E8F5E9    긍정 배경
  --red: #E05040            경고/삭제
  --red-light: #FCE4E0      경고 배경
  --gray: #9E9E9E           비활성
  --gray-light: #F5F5F0     비활성 배경
  --text-dark: #3D2B1F      본문 텍스트
  --text-mid: #6B4F3A       보조 텍스트
  --text-light: #A08878     약한 텍스트 (날짜, 메타)

크기:
  --radius: 14px            카드 모서리
  --radius-sm: 9px          소형 요소 모서리
  --shadow: 0 1px 8px rgba(0,0,0,0.08)
  --shadow-md: 0 4px 20px rgba(0,0,0,0.11)
  --shadow-sm: 0 1px 4px rgba(0,0,0,0.05)

폰트: 'Noto Sans KR', sans-serif
기본 글자크기: 14px
```

## 컴포넌트 패턴

**카드**: `background:#fff; border-radius:var(--radius); box-shadow:var(--shadow); padding:16~24px`  
**버튼 primary**: `background:var(--brown); color:#fff; border-radius:8px`  
**버튼 outline**: `background:transparent; border:1.5px solid var(--border); color:var(--text-mid)`  
**태그/뱃지**: `border-radius:5px; font-size:10~11px; font-weight:700; padding:2px 7px`  
**입력창**: `border:1.5px solid var(--border); border-radius:var(--radius-sm); background:var(--cream)`  
**섹션 제목**: `font-size:18px; font-weight:700; color:var(--brown); margin-bottom:16px`  
**메타 텍스트**: `font-size:11~12px; color:var(--text-light)`  

## 실행 지침

`/design` 호출 시 아래 순서로 작업합니다.

### 1단계 — 불일치 탐지

`index.html`을 읽고 다음을 검사합니다:

1. **하드코딩된 색상** — `style=` 인라인이나 CSS에서 `#[0-9a-fA-F]` 패턴이 토큰 목록에 없는 색상을 사용하는 경우
2. **하드코딩된 radius** — `border-radius`에 `var(--radius` 대신 숫자를 직접 쓴 경우 (단, 2px·4px 같은 의도적 소형값은 허용)
3. **font-family 누락** — 폰트를 별도 지정한 경우
4. **shadow 불일치** — 카드인데 shadow가 없거나, shadow 값이 토큰과 다른 경우
5. **버튼 스타일 혼용** — primary/outline 이외의 임의 스타일 버튼
6. **글자 크기 이탈** — 10px 미만이거나 20px 초과인 경우 (섹션 제목 제외)

### 2단계 — 보고

발견한 불일치를 아래 형식으로 보고합니다:

```
## 디자인 일관성 검사 결과

### 발견된 불일치 (N건)
| 위치 | 문제 | 수정 방향 |
|------|------|----------|
| line N | #5C3D1E → var(--text-dark) 아님 | --brown 또는 --text-dark 사용 |
...

### 수정하시겠어요?
```

### 3단계 — 수정 (사용자 승인 후)

사용자가 수정을 원하면 Edit 도구로 각 불일치를 토큰 기반으로 교체합니다.  
한 번에 수정할 범위가 10건 이상이면 카테고리별로 나눠서 진행합니다.

## 주의사항

- **기능 코드는 건드리지 않습니다** — style 속성과 CSS만 수정
- **의도된 예외는 남깁니다** — 도넛 차트 색상(`SD_COLORS`), 진행 바 동적 색상 등
- **인라인 style=""은 최소화** — 반복되는 패턴이면 CSS 클래스 제안
- 수정 전 반드시 현재 상태를 확인하고 변경 범위를 먼저 보고합니다
