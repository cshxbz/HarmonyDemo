import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';
import promptAction from '@ohos.promptAction';
import http from '@ohos.net.http';

@Entry
@Component
struct AsyncTaskTest {
  private static logTag = "AsyncTaskTest"
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Column() {
      Button('start async task')
        .type(ButtonType.Capsule)
        .width('50%')
        .height(50)
        .fontSize(15)
        .fontColor(Color.White)
        .onClick(() => {
          startAsync()
        })

      // Button('button_2')
      //   .type(ButtonType.Capsule)
      //   .width('50%')
      //   .height(50)
      //   .fontSize(15)
      //   .margin({ top: 20 })
      //   .fontColor(Color.White)
      //   .onClick(() => {
      //     promptAction.showToast({ message: 'button_2 clicked', duration: 1000 })
      //   })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#c0c0c0');
  }
}


async function startAsync() {
  let resp = await http.createHttp().request("http://www.baidu.com")
  promptAction.showToast({ message: `async task end`, duration: 1000 })
}
