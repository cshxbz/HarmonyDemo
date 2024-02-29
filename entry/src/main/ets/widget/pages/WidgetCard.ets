@Entry
@Component
struct WidgetCard {
  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';

  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'EntryAbility';

  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';

  build() {
    Column() {
      Row({space:10}) {
        Text('1')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('2')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('3')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('4')
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .layoutWeight(1)
      .width('100%')
      .margin({top:10,left:10,right:10})

      Row() {

      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#c0c0c0')
  }


  @Builder
  ToolItem(text: string) {
    Text(text)
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .borderRadius(10)
      .layoutWeight(1)
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
