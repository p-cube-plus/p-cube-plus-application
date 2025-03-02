# pcube+
세종대학교 게임 개발 동아리 판도라큐브 회원들을 위한 Flutter 앱입니다.

## 핵심 기능
- 회의 출석체크
- 동아리 일정, 회비 현황, 프로젝트 현황 확인
- 동아리에서 나의 활동 한 눈에 보기
- 동아리 물품 대여
- 임원진 회원 관리

## 프로젝트 구조
**App**: 앱 진입, foreground, background 설정을 하는 모듈<br>
**Presentation**: UI, ViewModel을 관리하는 모듈<br>
**Domain**: UseCase, value object (Entity) 를 관리하는 모듈<br>
**Data**: 데이터 CRUD를 관리하고 데이터 캐싱 로직을 관리하는 모듈<br>

- MVVM
  - UI는 ViewModel이 가지는 데이터를 관찰하고 보여줍니다.<br>
  상태관리는 Provider로 관리합니다.<br>
- 이벤트 기반
  - UI는 ViewModel이 보내는 이벤트를 StreamController로 감지합니다.<br>
  데이터 상태관리는 이벤트 및 FutureBuilder를 혼용중입니다.<br>
  rebuild 문제가 있을 떄만 데이터 상태를 이벤트로 관리합니다.<br>
- 단방향 데이터 흐름
  - [data -> domain -> viewModel -> UI]<br>
  데이터 흐름에 있어서 절대 이 구조가 깨지지 않습니다.<br>
- 클린 아키텍처
  - presentation은 domain에 의존, domain은 독립적, data는 domain에 의존합니다.<br>
  IoC는 get_it을 통해 관리중입니다. flutter에 Hilt같은 DI 프레임워크가 나오면 변경하는 걸 추천합니다.
- 도메인 주도 설계
  - 앱은 UI가 곧 도메인입니다.<br>
  data 모듈은 raw data (기본 자료형 기반 DTO, DAO 클래스),<br>
  domain 모듈은 value object(UI에 필요한 가공된 형태의 데이터)를 사용합니다.
- 테스트 주도 설계
  - 한 모듈 내에 전역적으로 쓰이는 핵심 클래스는 테스트 코드가 작성되어 있습니다.

[데이터 흐름 기준의 모듈 구조]

![image](https://github.com/user-attachments/assets/51c8bbfe-34b2-4ae1-8a8e-fe44fdd10ae4)

[의존성을 기반의 모듈 구조]

![image](https://github.com/user-attachments/assets/2c99c9cc-870b-4fa6-bf07-b9e19e7eac77)


## 유지보수에 대해
#### 1. 불필요한 패키지 지양
남이 만든 패키지에 의존하지 않고, 최대한 공식 패키지와 기본 Dart 기능을 활용합니다.<br>
꼭 필요할 경우 아래 2개 조건을 꼭 체크합니다.
1. 충분히 검증된 패키지인가? (Likes, Downloads, 구글 검색 자료 등 확인)
2. 유지보수되고 있는 패키지인가? (최신 flutter 버전에 맞춰서 최소 1년 내에 업데이트 내역이 있는지 확인)

#### 2. 최신 버전 유지
패키지 의존성을 줄이는 만큼 최신 버전 업데이트가 손쉽습니다.<br>
웬만하면 지속적으로 가장 높은 flutter 버전을 유지해주세요.

#### 3. 앱스토어 & 플레이스토어 모니터링
모바일은 SDK 및 정책이 빠르게 변화합니다.<br>
앱이 내려가지 않도록 꼭 SDK 버전 및 정책 등을 체크하고 계속 모니터링해주세요.



