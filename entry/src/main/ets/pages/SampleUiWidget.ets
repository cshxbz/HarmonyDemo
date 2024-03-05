import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';
import promptAction from '@ohos.promptAction';
import image from '@ohos.multimedia.image';

@Entry
@Component
struct SampleUiWidget {
  private readonly logTag = "SampleUiWidget"
  private context = getContext(this) as common.UIAbilityContext;
  @State private tiModel: CountTextModel = { textColor: Color.Black, count: 0 }
  @State private textA: string = 'A'
  @State private textB: string = 'B'
  @State private textC: string = 'C'

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

      Text(`click to change count ${this.tiModel.count}`)
        .width('100%')
        .height(50)
        .fontColor(this.tiModel.textColor)
        .textAlign(TextAlign.Center)
        .borderRadius(10)
        .fontSize(20)
        .backgroundColor(Color.White)
        .onClick(() => {
          this.tiModel.count++
          if (this.tiModel.textColor === Color.Black) {
            this.tiModel.textColor = Color.Blue
          } else {
            this.tiModel.textColor = Color.Black
          }
        })

      Row({ space: 10 }) {
        IconTextItem({ image: $r('app.media.app_icon'), text: this.textA })
          .layoutWeight(1)
          .onClick(() => {
            this.textA = 'x'
          })
        IconTextItem({ image: $r('app.media.app_icon'), text: this.textB })
          .layoutWeight(1)
          .onClick(() => {
            this.textB = 'x'
          })
        IconTextItem({ image: $r('app.media.app_icon'), text: this.textC })
          .layoutWeight(1)
          .onClick(() => {
            this.textC = 'x'
          })
      }
      .width('100%')
      .margin({ top: 30 })
      .alignItems(VerticalAlign.Center)

    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#c0c0c0');
  }
}


@Component
struct IconTextItem {
  image: string | PixelMap | Resource
  @Prop text: string

  build() {
    Column() {
      Image(this.image)
        .width('100%')
        .aspectRatio(1)

      Text(this.text)
        .fontColor(Color.Black)
        .fontSize(20)
        .margin({ top: 10 })
    }
    .alignItems(HorizontalAlign.Center)
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
}


interface CountTextModel {
  textColor: Color,
  count: number,
}
