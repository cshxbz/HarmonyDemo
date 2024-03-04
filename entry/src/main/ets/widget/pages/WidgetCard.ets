@Entry
@Component
struct WidgetCard {

  build() {
    Column({ space: 10 }) {
      Row({ space: 10 }) {
        Text('1')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.postCardActionToJumpPage('pages/SampleUiWidget')
          })
        Text('2')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.postCardActionToJumpPage('pages/AsyncTaskTest')
          })
        Text('3')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.postCardActionToJumpPage('pages/EventHubTest')
          })
        Text('4')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.postCardActionToJumpPage('pages/PermissionsTest')
          })
      }
      .layoutWeight(1)
      .width('100%')

      Row({ space: 10 }) {
        Text('5')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.postCardActionToJumpPage('pages/FileDownloadTest')
          })
        Text('6')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
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
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('8')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
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
