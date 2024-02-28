import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct SampleUiWidget {
  private readonly logTag = "SampleUiWidget"
  private context = getContext(this) as common.UIAbilityContext;
  @State private count: number = 0

  build() {
    Column() {

      Button('Button')
        .type(ButtonType.Capsule)
        .fontColor(Color.White)
        .fontSize(15)
        .onClick(() => {
          showToast()
        })
        .width('40%')
        .height(50)
        .margin(20)
        .visibility(Visibility.Visible)

      Text(`click to change count ${this.count}`)
        .width('100%')
        .height(50)
        .textAlign(TextAlign.Center)
        .borderRadius(10)
        .fontSize(20)
        .backgroundColor(Color.White)
        .onClick(() => {
          this.count++
        })

      Image($r('app.media.icon'))
        .margin({ top: 20 })
        .width(100)
        .height(100)

    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#c0c0c0');
  }
}



function showToast() {
  try {
    promptAction.showToast({
      message: 'Clicked Button',
      duration: 1000,
    });
  } catch (error) {
    console.error(`showToast args error code is ${error.code}, message is ${error.message}`);
  }
  ;
}

