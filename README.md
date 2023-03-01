# Notification Center - Observer Pattern

![f1fd46216bbbce117b480ff9462ed087d23ea70cefa14ac54d643769b0dee77409552a609a709a5c91bdac313ac13b32f31ffc578f4d8cfe4d9639831bcb41460e4c065688e73bab8351b4fc49b15512b0f9ca7af54d77a438c0dc3ee891a206](https://user-images.githubusercontent.com/57012734/197365847-e7392f26-51e3-43b4-8dc3-d3e5a1bd1eb3.gif)

- 한 Object의 상태가 변하면 등록된 모든 Object에게 알림 (1:多 커뮤니케이션)
- 본질적으로 Publish and Subscribe Model입니다.
- Subject와 Observer가 서로 알지 못해도 커뮤니케이션이 가능합니다.
- Notification뿐만 아니라 Combine도 훌륭한 Observer Pattern입니다!

## Notification의 기본 메커니즘

1) Subject에서 Notification Object를 Notification Center로 발송 - Post
2) NotificationCenter에서 Observer에게 전송 - Broadcast(여기까지 동기처리)
3) 각 Observer에서 event 처리

<img width="542" alt="Screen Shot 2022-10-23 at 8 24 20 AM" src="https://user-images.githubusercontent.com/57012734/197365952-0b46393d-f655-4071-96c0-ad263aef1009.png">

- Notification Center는 Post 이후 모든 Observer에게 Broadcast를 완료 할 때 까지 대기하게 됩니다.
- 따라서 비동기처리를 위해서는 Notification queue를 이용해야 합니다.

<img width="633" alt="Screen Shot 2022-10-23 at 8 30 07 AM" src="https://user-images.githubusercontent.com/57012734/197366100-0e5750c7-b701-4bc6-a552-43588abfff7e.png">

## Notification Object란?
- Subject와 Observer 사이에 보내지는 Object입니다.
- NSNotification의 instance
    - name: Notification Object끼리 식별하게 해줌 => 고유한 Name 필요
    - object: 이 parameter의 Object만 notification을 post 할 수 있습니다. nil이면 Object 체크를 하지 않습니다. (따라서 Subject 본인이나 nil이 자주 들어가겠죠)
    - userInfo: Event와 관련된 정보를 저장한 Dictionary 입니다.

## 구현을 해봅시다

- Sample Code는 [여기에서🔗](https://github.com/Kelly-Chui/ObserverPattern) 다운 받을 수 있습니다.
- 두 개의 뷰(MainView, SubView)가 존재하고 MainView 내부의 2개의 버튼 조작에 따라 SubView의 배경색깔을 바꾸는 아주아주아주 간단한 코드입니다.

#### 앞의 숫자는 구현 순서와 관련이 없음(순서는 본인 편한대로..)
1) Notification Name을 Notification.Name의 extension으로 선언합니다. 꼭 필요한 작업은 아니지만, Observer를 등록하고, post하는 각각의 코드마다 하드코딩을 할 수고를 줄여주고 코드를 깔끔하게 해줍니다.
```
extension Notification.Name {
    static let colorChange = Notification.Name("change")
}
```
2) SubViewController를 Observer로 등록합니다.
```
// SubViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(changeBackGround(notification:)), name: Notification.Name.colorChange, object: nil)
    }
```
3) notification을 Broadcast 받았을 때 처리해줄 Method를 선언합니다. Sample에선 UserInfo를 UIColor로 받아 배경화면을 변화시켜줍니다.
```
// SubViewController

    @objc func changeBackGround(notification: Notification) {
        guard let object = notification.userInfo?[NotificationKey.color] as? UIColor else { return }
        self.view.backgroundColor = object
    }
```
4) MainViewController에 post Method를 작성합니다. Sample에선 UIButton의 Selector Method 내부에 작성되어 있습니다.
```
// MainViewController

    @objc func tapRed() {
        NotificationCenter.default.post(
        name: Notification.Name.colorChange,
        object: nil,
        userInfo: [NotificationKey.color: UIColor.systemRed])
    }
    
    @objc func tapBlue() {
        NotificationCenter.default.post(
        name: Notification.Name.colorChange,
        object: nil,
        userInfo: [NotificationKey.color: UIColor.systemBlue])
    }
```

- 이제 확인을 해봅시다!

![Screen_Recording_2022-10-23_at_10_06_27_AM_AdobeExpress](https://user-images.githubusercontent.com/57012734/197368990-d345a76f-c1ef-4a93-bb54-9cd7e14028cf.gif)
<img src = "https://user-images.githubusercontent.com/57012734/194938983-37fab98a-5712-42cd-84c7-b63d88690681.png" width = "20%" height = "20%">
