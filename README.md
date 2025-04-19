# 💰 TrendBit - 트렌디한 암호화폐

- **TrendBit**는 Trend + BitCoin의 합성어로 암호화폐의 최신 정보를 알 수 있는 앱입니다.
- 암호화폐의 현재가와 최신 트렌드 검색어를 파악하여 관리할 수 있습니다.

<br>

# 주요 기능

### 거래소 화면
|   거래소 화면   | 
|  :-------------: |
| <img width=200 src="https://github.com/user-attachments/assets/58a13ad0-f929-4165-b027-23f2ae94a51b"> | 
- 암호화폐의 대한 정보를 확인할 수 있습니다.
- 정렬 기능(현재가/전일대비/거래대금)을 통해 원하는 데이터를 볼 수 있습니다.
- 암호화폐의 가격의 등락을 한눈에 파악할 수 있습니다.

<br>

### 인기검색어 화면
|   인기검색어 화면   | 
|  :-------------: |
| <img width=200 src="https://github.com/user-attachments/assets/5960767c-df83-4713-b04e-8ebe1394a2be"> | 
- 원하는 가상화폐를 검색할 수 있습니다.
- 최신 코인 인기 검색어를 확인할 수 있습니다.
- 최신 인기 NFT 검색어를 확인할 수 있습니다.

<br>

### 검색 화면
|   검색 화면   | 
|  :-------------: |
| <img width=200 src="https://github.com/user-attachments/assets/452cc119-c815-4c6f-9407-af721517da5f"> | 
- 검색 정보에 대한 가상화폐 정보를 볼 수 있습니다.
- 즐겨찾기 버튼을 통해 해당 코인에 대해 즐겨찾기를 추가/해제할 수 있습니다.


<br>

### 상세 화면
|   상세 화면   | 
|  :-------------: |
| <img width=200 src="https://github.com/user-attachments/assets/b8357582-21dc-4bbd-8fbf-8d43e727e503"> | 
- 가상화폐 일주일에 대한 차트를 확인할 수 있습니다.
- 종목 정보를 확인할 수 있습니다.
- 투자 지표를 확인할 수 있습니다.

<br>


### 네트워크 단절 화면
|   네트워크 단절 화면   | 
|  :-------------: |
| <img width=200 src="https://github.com/user-attachments/assets/fd91715d-9632-4d63-8a5e-fc4b37ea72ec"> | 
- 인터넷 연결이 끊긴 경우, 연결 상태를 안내하는 화면이 자동으로 나타납니다.

<br>

# 🎯 앱 기술 설명

### 웹소켓 기반 데이터 반영

- 수신된 시세 데이터는 SIMPLE 포맷의 경량 JSON 구조로 처리되며 각 코인을 고유 식별자(`code`) 기준으로 `딕셔너리` 캐시 구조에 저장하여 최적화
- 실시간으로 업데이트되는 데이터는 RxSwift 스트림을 통해 전달되며 ViewModel에서 Observable형태로 구독할 수 있도록 설계
- `DiffableDataSource`와 `Snapshot`을 사용하여 변경된 셀만 업데이트되도록 최적화하였으며 이에 따라 불필요한 전체 리로드를 방지하여 최적화
- 가격이 변동된 셀에 대해서는 하이라이트 애니메이션을 적용하여 시세 변화에 대한 시각적 피드백을 제공하여 UX경험 향상

<br>

### 네트워크 단절 상황 대응

- `NWPathMonitor`를 백그라운드 글로벌 큐에서 실행하여 네트워크 단절된 경우 해당 UIWindow의 루트 뷰 컨트롤러를 기준으로 단절 화면 노출
- `SceneDelegate`의 생명주기를 활용하여 앱 활성화 시 네트워크 상태 감지를 자동으로 시작하고 연결 해제 시 감지를 중단하도록 설계

<br>

### 네트워크 과부하 방지를 위한 Call 수 제한

- 동일한 검색어 반복 시, 이전 결과를 재사용하도록 하여 불필요한 API 호출을 방지하여 과도한 트래픽 최소화
- 사용자 경험을 고려해 결과가 재사용되는 경우에 UI상으로는 새 검색과 동일한 인터랙션을 제공하여 UX 일관성 유지

<br>

### 네트워크 통신 요청 시 상호 작용 제한

- `UIWindowScene`의 루트 윈도우를 기준으로 `UIActivityIndicatorView`를 오버레이 형태로 표시하여 전역 로딩 상태 피드백 제공
- 네트워크 요청 중에는 사용자 상호작용을 차단하여 중복 입력이나 예기치 않은 동작 방지

<br>

# 🎯 개발 환경

![iOS](https://img.shields.io/badge/iOS-16%2B-000000?style=for-the-badge&logo=apple&logoColor=white)

![Swift](https://img.shields.io/badge/Swift-5.9-FA7343?style=for-the-badge&logo=swift&logoColor=white)

![Xcode](https://img.shields.io/badge/Xcode-16.2-1575F9?style=for-the-badge&logo=Xcode&logoColor=white)

<br>

# 📅 개발 정보

- 개발 기간: 2025.03.06 ~ 2025.03.11 (2025.04.19 update)
- 개발인원: 1명
