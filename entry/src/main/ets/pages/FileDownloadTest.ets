import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';
import promptAction from '@ohos.promptAction';
import request from '@ohos.request';

@Entry
@Component
struct FileDownloadTest {
  private readonly logTag = "FileDownloadTest"
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Column() {

      Button('start download')
        .type(ButtonType.Capsule)
        .fontColor(Color.White)
        .fontSize(15)
        .onClick(() => {

        })
        .width('40%')
        .height(50)
        .margin(20)
        .visibility(Visibility.Visible)

    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#c0c0c0');
  }

  downloadFile() {
    let filesDir = this.context.filesDir
    request.downloadFile(this.context,{url:''},()=>{})

  }
}



