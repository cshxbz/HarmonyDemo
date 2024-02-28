import common from '@ohos.app.ability.common';
import { Beans } from 'ets/Bean'

@Entry
@Component
struct EventHubTest {
  private readonly  logTag = "EventHubTest"
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Column() {

      Button('send event')
        .type(ButtonType.Capsule)
        .fontColor(Color.White)
        .fontSize(15)
        .onClick(() => {
          this.context.eventHub.emit("test_event", [new Beans.TestData("a", 1)])
        })
        .width('40%')
        .height(50)
        .margin(20)

    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#c0c0c0');
  }
}


