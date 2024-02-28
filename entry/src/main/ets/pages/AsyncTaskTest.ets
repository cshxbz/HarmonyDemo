import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';
import promptAction from '@ohos.promptAction';
import http from '@ohos.net.http';

@Entry
@Component
struct AsyncTaskTest {
  private readonly logTag = "AsyncTaskTest"
  private context = getContext(this) as common.UIAbilityContext;
  @State private httpRespContent: string = ''

  build() {
    Scroll() {
      Column() {
        Button('start async task')
          .type(ButtonType.Capsule)
          .width('50%')
          .height(50)
          .fontSize(15)
          .fontColor(Color.White)
          .onClick(() => {
            this.startAsyncTask()
          })

        Button('http request')
          .type(ButtonType.Capsule)
          .width('50%')
          .height(50)
          .fontSize(15)
          .margin({ top: 20 })
          .fontColor(Color.White)
          .onClick(() => {
            this.httpRequestAsync()
          })

        Text(this.httpRespContent)
          .fontSize(15)
          .margin({ top: 20 })
          .fontColor(Color.Black)

      }
      .alignSelf(ItemAlign.Start)
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#c0c0c0')
    .scrollable(ScrollDirection.Vertical)
  }

  onPageShow() {
    hilog.info(0x0000, this.logTag, "%{public}s", ">> onPageShow")
  }

  onPageHide() {
    hilog.info(0x0000, this.logTag, "%{public}s", ">> onPageHide")
  }

  onBackPress() {
    hilog.info(0x0000, this.logTag, "%{public}s", ">> onBackPress")
  }

  async httpRequestAsync() {
    this.httpRespContent = ''
    let resp = await http.createHttp().request("http://www.baidu.com", { method: http.RequestMethod.GET })
    this.httpRespContent = `code: ${resp.responseCode} \n ${resp.result}`
  }

  async startAsyncTask() {
    try {

      let result = await new Promise<string>((resolve, reject) => {
        setTimeout(() => {
          let randomNumber = Math.random() * 10
          if (randomNumber > 5) {
            resolve('success')
          } else {
            reject(new Error('failed'))
          }
        }, 2000)
      })

      promptAction.showToast({ message: `async end -- ${result}`, duration: 1000 })

    } catch (e) {
      promptAction.showToast({ message: `async end -- ${e}`, duration: 1000 })
    }
  }

  async startAsyncTask2() {
    let result = await new Promise<string>((resolve, _) => {
      setTimeout(() => {
        let randomNumber = Math.random() * 10
        if (randomNumber > 5) {
          resolve('success')
        } else {
          resolve('failed')
        }
      }, 2000)
    })
    promptAction.showToast({ message: `async end -- ${result}`, duration: 1000 })
  }
}

