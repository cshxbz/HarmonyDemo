import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';
import router from '@ohos.router';

@Entry
@Component
struct MainPage {
  private static logTag = "MainPage"
  private context = getContext(this) as common.UIAbilityContext;
  private readonly itemArr: FeatureItem[] = [
    new FeatureItem("基础UI组件", 'pages/SampleUiWidget'),
    new FeatureItem("异步任务", 'pages/AsyncTaskTest'),
    new FeatureItem("权限申请", ''),
    new FeatureItem("事件总线", ''),
    new FeatureItem("文件下载", ''),
  ]

  build() {
    Column() {

      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.itemArr, (item: FeatureItem, index: number) => {
          ListItem() {
            Text(`${index}-${item.name}`)
              .padding({ top: 20, bottom: 20 })
              .fontSize(15)
              .borderRadius(10)
              .fontColor(Color.Black)
              .width('100%')
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.White)
              .onClick(() => {
                hilog.info(0, MainPage.logTag, "%{public}s", `clicked -- ${item.name}`)
                jumpToPage(this.context, item.pageUrl)
              })
          }
        })
      }
      .margin({ top: 20 })
      .width('95%')
      .height('100%')
      .listDirection(Axis.Vertical)
      .divider({ strokeWidth: 0, color: 0x00000000, startMargin: 5, endMargin: 5 })
      .onScrollIndex((firstIndex: number, lastIndex: number) => {

      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#c0c0c0')
  }
}


function jumpToPage(context: common.UIAbilityContext, pageUrl: string) {
  router.pushUrl({
    url: pageUrl,
    params: {
      data1: 'message',
      data2: {
        data3: [123, 456, 789]
      }
    }
  }, (err) => {
    if (err) {
      console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
      return;
    }
    console.info('pushUrl success');
  });
}


class FeatureItem {
  public name: string;
  public pageUrl: string;

  constructor(name: string, pagePath: string) {
    this.name = name;
    this.pageUrl = pagePath
  }
}
