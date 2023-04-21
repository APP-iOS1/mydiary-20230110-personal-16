# Avocado: 뽀모도로 공부 스케쥴러

<img width= 300 src="https://user-images.githubusercontent.com/99034396/233616197-55ecdaf5-ac7b-4e72-889e-d113d0bbacd3.png"></img>


# 앱 소개

효율적으로 집중할 수 있는 뽀모도로 기법으로 학습(이외 작업)을 하고 그 시간 동안에 무엇을 얼만큼 했고, 어떤 것을 느끼고 배웠는지 기록할 수 있는 앱이다. 꾸준히 기록을 남겨서 성취감을 더할 수 있다. 정체성을 더하고 싶어서 좋아하는 아보카도를 캐릭터로 넣어주었다.

💡 뽀모도로란?
타이머를 이용해서 25분간 집중해서 일을 한 다음 5분간 휴식하는 방식이다. '뽀모도로'는 이탈리아어로 토마토를 뜻한다.

<br>

# 어떻게 만들게 됐나요?

공부를 하다가 종종 번아웃을 경험한 적이 있었다. 많은 것을 해야한다는 생각에 작은 일도 시작을 못했다.

그러다가 뽀모도로 기법을 알게 됐는데, 30분만 집중한다는 생각으로 앉으면 몇 시간 동안 집중할 수 있었다.

또 그 기록을 돌아보면 성취감을 얻을 수 있었다. 그래서 앱으로 만들게 되었다.

<img width="1000" alt="과거 노션으로 뽀모도로 기법을 사용하고 남겨놓은 기록의 일부이다" src="https://user-images.githubusercontent.com/99034396/233617290-efcfe7ca-f8c0-44b2-b197-06f6f9b198f0.png">
과거 노션으로 뽀모도로 기법을 사용하고 남겨놓은 기록의 일부이다.

<br>

# 핵심 키워드

- SwiftUI (iOS 16.0 +)
- Core Data
- MVVM
- 반응형 UI
- 다크 모드 대응

<br>

# 구현기능

- 뽀모도로 기법에 기반한 학습 시간 및 휴식 시간, 목표 설정 기능
- 학습 진행률을 반응형 UI를 이용하여 시각적으로 표현
- 학습이 끝나면 학습 내용과 학습을 통해 배운 점 작성 기능
- Core Data를 이용한 계획 생성 및 저장, 삭제 기능

<br>

# 구동 화면
|<img src="https://user-images.githubusercontent.com/99034396/233617520-ea13f0e6-d9ac-4f12-bd2f-5ee57b4e004a.gif"></img>|<img src="https://user-images.githubusercontent.com/99034396/233617543-92127c0b-2dbc-4d1c-a2cd-83596119fc8a.gif"></img>|<img src="https://user-images.githubusercontent.com/99034396/233617555-78323655-b98d-4ae5-943b-3650ced042fb.gif"></img>|
|:-:|:-:|:-:|
|`새로운 학습계획 생성`|`학습 진행률을 표현한 반응형UI`|`학습내용 및 달성률`|

<br>

# 화면 이미지
|<img src="https://user-images.githubusercontent.com/99034396/233618932-cee086fa-f7e0-4514-bd84-e8e05c049545.png"></img>|<img src="https://user-images.githubusercontent.com/99034396/233618950-d3ee4693-0504-407c-b47a-7675ab9b516b.png"></img>|<img src="https://user-images.githubusercontent.com/99034396/233618957-11d6e8cf-2168-4846-987c-977cd94cd8e2.png"></img>|
|:-:|:-:|:-:|
|`OngoingView`|`AddingView`|`OngoingView(after adding plan)`|
|<img src="https://user-images.githubusercontent.com/99034396/233618982-840c7c81-1d2d-4e7e-b777-7cca4e6a99ca.png"></img>|<img src="https://user-images.githubusercontent.com/99034396/233618986-471357bd-1fa7-4dbc-a49c-92b3b2273552.png"></img>|<img src="https://user-images.githubusercontent.com/99034396/233618989-a934176a-33ec-4d15-a843-a67e3eb31c0a.png"></img>|
|`FinishingView`|`FinishedListView`|`FinishedStudyDetail`|

<br>

# 구현 예정 기능

- 타이머 기능
    - 설정한 학습율을 달성하면 타이머를 통해 휴식 시간을 알려줌
- 학습 기록 통계 기능
    - 월 별로 통계를 만들어서 학습량을 파악할 수 있음

<br>
