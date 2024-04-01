import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { logUtil } from 'app_base_lib'

@Entry
@Component
struct MainPage {
  private readonly logTag = "MainPage"
  private context = getContext(this) as common.UIAbilityContext;
  private readonly itemArr: FeatureItem[] = [
    new FeatureItem("基础UI组件", 'pages/SampleUiWidget'),
    new FeatureItem("异步任务", 'pages/AsyncTaskTest'),
    new FeatureItem("权限申请", 'pages/PermissionsTest'),
    new FeatureItem("事件总线", 'pages/EventHubTest'),
    new FeatureItem("文件下载", 'pages/FileDownloadTest'),
    new FeatureItem("WebView", 'pages/WebComponent'),
  ]

  aboutToAppear() {
    logUtil.i(this.logTag, ">> aboutToAppear")
    //订阅事件
    this.context.eventHub.on("test_event", (...data) => {
      promptAction.showToast({ message: `MainPage received test_event -- ${data}` })
    })
  }

  aboutToDisappear() {
    logUtil.i(this.logTag, ">> aboutToDisappear")
    //取消订阅事件
    this.context.eventHub.off("test_event")
  }

  onPageShow() {
    logUtil.i(this.logTag, ">> onPageShow")
  }

  onPageHide() {
    logUtil.i(this.logTag, ">> onPageHide")
  }

  build() {
    Column() {

      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.itemArr, (item: FeatureItem, index: number) => {
          ListItem() {
            Text(item.name)
              .padding({ top: 20, bottom: 20 })
              .fontSize(15)
              .borderRadius(10)
              .fontColor(Color.Black)
              .width('100%')
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.White)
              .onClick(() => {
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
