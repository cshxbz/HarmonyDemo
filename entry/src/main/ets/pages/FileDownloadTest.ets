import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';
import promptAction from '@ohos.promptAction';
import request from '@ohos.request';
import { logUtil } from 'app_base_lib'
import fs from '@ohos.file.fs';
import File from '@system.file';

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
          this.downloadFile()
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

  async downloadFile() {
    let filesDir = this.context.cacheDir
    let url = "http://speedtest.tele2.net/100MB.zip"
    let filePath = `${filesDir}/testFile100.zip`

    let task = await request.downloadFile(this.context, { url: url, filePath: filePath })
    task.on('progress', (receivedSize, totalSize) => {
      logUtil.i(this.logTag, `on progress -- receivedSize: ${receivedSize} , totalSize: ${totalSize}`)
    })

    task.on('complete', () => {
      logUtil.i(this.logTag, `on complete -- `)
    })

    task.on('fail', (err) => {
      logUtil.i(this.logTag, `on fail -- err: ${err}`)
    })

    task.on('remove', () => {
      logUtil.i(this.logTag, `on remove --`)
    })
  }


  doFileTest(){
    let filesDir = this.context.filesDir
    let file = fs.openSync(filesDir + '/test.txt', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
  }


}



