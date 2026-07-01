---
created: 2026-05-30
tags: [공부, 스킬, LLM-council, 의사결정]
type: study
status: reference
---

> 하나의 AI 답변을 그냥 믿지 말고, 서로 다른 관점의 자문위원 5명에게 토론·상호검토시킨 뒤 종합 판결을 받는 Claude Code 스킬. Andrej Karpathy의 _LLM Council_ 방법론을 Claude 서브에이전트로 옮긴 것.

![[claude-council-skill-kr-01.png]]

## 한 줄 요약

**5명의 AI 자문위원이 질문을 놓고 독립적으로 분석 → 익명 상호검토(peer review) → 의장(Chairman)이 최종 판결**을 내려, 단일 AI 답변의 맹점·확신편향을 줄여준다.

---

## 작동 흐름 (4단계)

### 1️⃣ 질문 프레이밍

`council this` 등 트리거 입력 시, 워크스페이스의 `CLAUDE.md`·`memory/` 폴더를 자동 스캔해 컨텍스트를 보강한 뒤 중립적인 질문으로 재구성한다.

### 2️⃣ 5명 자문위원 병렬 분석

5개 서브에이전트가 **동시에** 각자의 관점으로 150~300자 답변 (헤지 금지, 자기 관점에 완전히 몰입).

### 3️⃣ 익명 상호검토 (peer review)

5개 답변을 **A~E로 익명화·셔플**한 뒤, 5명이 서로 평가. 세 가지 질문에 답한다 — ① 가장 강한 답변은? ② 가장 큰 맹점은? ③ **5명 모두가 놓친 것은?**

### 4️⃣ 의장 종합 판결

원 질문 + 5개 답변(de-anonymized) + 5개 검토를 받아 최종 판결 생성.

---

## 5명의 자문위원

|자문위원|사고 방식|핵심 질문|
|---|---|---|
|**Contrarian** (반대론자)|무엇이 틀렸나, 치명적 결함 탐지|"What could fail?"|
|**First Principles** (제1원리)|가정을 걷어내고 본질 재구성|"What are we really solving?"|
|**Expansionist** (확장론자)|놓친 상방·인접 기회 발굴|"What upside are we missing?"|
|**Outsider** (외부인)|맥락 제로, 전문가의 맹점 포착|"Does this make sense to someone new?"|
|**Executor** (실행가)|당장 실행 가능성·첫 단계|"What do you do Monday morning?"|

**세 가지 긴장 구조:** Contrarian↔Expansionist(하방 vs 상방), First Principles↔Executor(재고 vs 실행), Outsider는 가운데서 모두를 정직하게.

---

## 최종 판결(COUNCIL VERDICT) 구조

1. **Where the Council Agrees** — 여러 위원이 독립적으로 수렴한 고신뢰 신호

1. **Where the Council Clashes** — 진짜 의견 충돌 (얼버무리지 않고 양쪽 제시)

1. **Blind Spots the Council Caught** — peer review에서만 드러난 맹점

1. **The Recommendation** — "It depends" 금지, 명확한 실제 답 (의장은 소수의견 편들 수 있음)

1. **The One Thing to Do First** — 단 하나의 구체적 다음 행동

결과물: 작업 폴더에 `**council-report-[timestamp].html**` (스캔용 비주얼 리포트, 자동 오픈) + `**council-transcript-[timestamp].md**` (전체 기록) 자동 생성.

---

## 사용법

- **MANDATORY 트리거:** `council this`, `run the council`, `war room this`, `pressure-test this`, `stress-test this`, `debate this`

- **STRONG 트리거(실제 결정·트레이드오프와 결합 시):** "A안이냐 B안이냐", "어떤 옵션", "이게 맞는 선택일까", "validate this", "I'm torn between"

- **발동 안 함:** 단순 yes/no, 사실 조회, 트레이드오프 없는 캐주얼 질문

### 좋은 council 질문 예시

- "$97 워크숍 vs $497 코스, 뭘 출시할까?"

- "이 3가지 포지셔닝 중 가장 강한 건?"

- "X에서 Y로 피벗하려는데, 미친 짓일까?"

- "VA를 고용할까, 자동화를 먼저 만들까?"

---

## 설치 정보

- **출처:** YonasValentin/llm-council (GitHub) — Karpathy의 LLM Council 기반

- **설치 경로:** `~/.claude/skills/llm-council/SKILL.md`

- **설치 방법:** 배포된 `.skill`(zip) 파일을 `~/.claude/skills/` 에 압축 해제

- **버전 비교:** ngmeyer/council-review는 `/council-review` 슬래시 커맨드 + 모드 옵션(`--quick`/`--adversarial`) 제공. YonasValentin 버전이 자연어 트리거 + HTML 리포트 + transcript 자동생성으로 인포그래픽과 가장 일치.

---

_설치일: 2026-05-30 · macOS · ~/.claude/skills/llm-council/_

![[llm-council.skill]]

  

[🏛️[Council 사례] 위노아 SaaS 유지 vs AI 에이전트 전환 (2026-05-30)](https://www.notion.so/Council-SaaS-vs-AI-2026-05-30-370511e3542e8108a68ecd3a94c1d13b?pvs=21)