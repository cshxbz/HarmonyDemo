import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';

export default class EntryAbility extends UIAbility {
  private logTag: string = "EntryAbility"
  private logFormat: string="%{public}s"

  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    this.context.eventHub.on('custom_event', (...data) => {
      let strArr = data as string[]
      hilog.info(0x0000,this.logTag,this.logFormat,strArr.toString())
    })

  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, this.logTag, this.logFormat, 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/MainPage', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, this.logFormat, 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, this.logFormat, 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, this.logTag, this.logFormat, 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, this.logTag, this.logFormat, 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, this.logTag, this.logFormat, 'Ability onBackground');
  }
}
