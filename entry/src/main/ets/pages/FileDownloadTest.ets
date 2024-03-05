import common from '@ohos.app.ability.common';
import request from '@ohos.request';
import { logUtil } from 'app_base_lib'
import fs from '@ohos.file.fs';

@Entry
@Component
struct FileDownloadTest {
  private readonly logTag = "FileDownloadTest"
  private context = getContext(this) as common.UIAbilityContext;
  @State private progressPercent: number = 0
  private downloadState: DownloadState = DownloadState.None
  @State private btnText: string = 'start'

  build() {
    Column() {

      Button(this.btnText)
        .type(ButtonType.Capsule)
        .fontColor(Color.White)
        .fontSize(15)
        .onClick(() => {
          this.performBtnClick()
        })
        .width('40%')
        .height(50)
        .margin(20)
        .visibility(Visibility.Visible)

      Progress({ value: this.progressPercent, total: 100, type: ProgressType.Linear })
        .width('80%')

      Text(`${this.progressPercent.toFixed(2)}%`)
        .fontColor(Color.Black)
        .fontSize(20)
        .margin({ top: 20 })

    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#c0c0c0');
  }

  performBtnClick() {
    switch (this.downloadState) {
      case DownloadState.None:
        this.downloadFile()
        break
      case DownloadState.Downloading:
        this.pauseDownload()
        break
      case DownloadState.Pause:
        if (this.downloadTask != null) {
          this.restoreDownload()
        }
        break
    }
  }

  private downloadTask: request.DownloadTask = null

  /**
   * 暂停下载
   */
  async pauseDownload() {
    let result = await this.downloadTask.suspend()
    logUtil.i(this.logTag, `pauseDownload -- ${result}`)
    this.downloadState = DownloadState.Pause
    this.btnText = 'restore'
  }

  /**
   * 恢复下载
   */
  async restoreDownload() {
    let result = await this.downloadTask.restore()
    logUtil.i(this.logTag, `pauseDownload -- ${result}`)
    this.downloadState = DownloadState.Downloading
    this.btnText = `pause`
  }

  /**
   * 开始下载
   */
  async downloadFile() {
    let filesDir = this.context.cacheDir
    let url = "https://imgkub.com/images/2022/03/09/pexels-francesco-ungaro-15250411.jpg"

    let filePath = `${filesDir}/sample.jpg`

    //删除文件，如果文件已存在，会报下载失败
    await fs.unlink(filePath)

    try {
      this.downloadTask = await request.downloadFile(this.context, { url: url, filePath: filePath })
      this.downloadTask.on('progress', (receivedSize, totalSize) => {
        logUtil.i(this.logTag, `on progress -- receivedSize: ${receivedSize} , totalSize: ${totalSize}`)
        this.progressPercent = (receivedSize / totalSize) * 100
      })

      this.downloadTask.on('complete', () => {
        logUtil.i(this.logTag, `on complete -- `)
        this.downloadState = DownloadState.Complete
        this.btnText = `completed`
        this.downloadTask = null
      })

      this.downloadTask.on('fail', (err) => {
        logUtil.i(this.logTag, `on fail -- err: ${err}`)
      })

      this.downloadTask.on('remove', () => {
        logUtil.i(this.logTag, `on remove --`)
      })

      this.downloadState = DownloadState.Downloading
      this.btnText = "pause"

    } catch (err) {
      logUtil.i(this.logTag, `download err: ${err.code} -- ${err.message}`)
    }

  }
}


enum DownloadState {
  None, Downloading, Pause, Complete
}


