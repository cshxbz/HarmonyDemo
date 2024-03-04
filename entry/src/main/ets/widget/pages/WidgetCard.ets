@Entry
@Component
struct WidgetCard {
  build() {
    Column({ space: 10 }) {
      Row({ space: 10 }) {
        Text('router_1')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .layoutWeight(1)
          .fontSize(8)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.postCardActionToJumpPage('pages/SampleUiWidget')
          })
        Text('router_2')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .fontSize(8)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.postCardActionToJumpPage('pages/AsyncTaskTest')
          })
        Text('router_3')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .fontSize(8)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.postCardActionToJumpPage('pages/EventHubTest')
          })
        Text('router_4')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .fontSize(8)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.postCardActionToJumpPage('pages/PermissionsTest')
          })
      }
      .layoutWeight(1)
      .width('100%')

      Row({ space: 10 }) {
        Text('call')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .fontSize(8)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {

            //发送call事件
            postCardAction(this, {
              'action': 'call',
              'abilityName': 'EntryAbility', // 只能跳转到当前应用下的UIAbility
              'params': {
                'method': 'funA', // 在EntryAbility中调用的方法名
                'num1': 365,
                'str1': 'test_str',
              }
            });

          })
        Text('message')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .fontSize(8)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            postCardAction(this, {
              'action': 'message',
              'params': {
                'msgTest': 'messageEvent'
              }
            });


          })
        Text('7')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .fontSize(8)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('8')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .fontSize(8)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(15)
    .backgroundColor('#c0c0c0')
  }

  postCardActionToJumpPage(pageUrl: string) {
    postCardAction(this, {
      'action': 'router',
      'abilityName': 'EntryAbility', // 只能跳转到当前应用下的UIAbility
      'params': {
        'targetPageUrl': pageUrl // 在EntryAbility中处理这个信息
      }
    })
  }
}
