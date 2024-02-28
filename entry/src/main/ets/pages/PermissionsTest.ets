import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import bundleManager from '@ohos.bundle.bundleManager';

@Entry
@Component
struct PermissionsTest {
  private readonly logTag = "PermissionsTest"
  private context = getContext(this) as common.UIAbilityContext;
  private readonly permissions: Array<Permissions> = [
    'ohos.permission.READ_CALENDAR',
    'ohos.permission.LOCATION',
    'ohos.permission.CAMERA',
    'ohos.permission.MICROPHONE',
    'ohos.permission.READ_MEDIA',
  ];

  build() {
    Column() {
      Column() {

        List({ space: 10, initialIndex: 0 }) {
          ForEach(this.permissions, (item: Permissions, index: number) => {
            ListItem() {
              Text(item)
                .padding({ top: 20, bottom: 20 })
                .fontSize(15)
                .borderRadius(10)
                .fontColor(Color.Black)
                .width('100%')
                .textAlign(TextAlign.Center)
                .backgroundColor(Color.White)
                .onClick(() => {
                  //请求权限
                  this.reqPermissionsFromUser([item])
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
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#c0c0c0');
  }

  reqPermissionsFromUser(permissions: Array<Permissions>): void {
    let atManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    atManager.requestPermissionsFromUser(this.context, permissions).then((data) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] === 0) {
          // 用户授权，可以继续访问目标操作

        } else {
          // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
          promptAction.showToast({ message: '已拒绝权限，请在设置中打开权限', duration: 1000 })
          this.openPermissionsInSystemSettings()
          return;
        }
      }
      // 授权成功
      promptAction.showToast({ message: '已授权', duration: 1000 })
    }).catch((err) => {
      console.error(`requestPermissionsFromUser failed, code is ${err.code}, message is ${err.message}`);
    })
  }

  /**
   * 跳转到设置界面
   */
  openPermissionsInSystemSettings(): void {
    let bundleName = this.context.applicationInfo.name
    let wantInfo = {
      action: 'action.settings.app.info',
      parameters: {
        settingsParamBundleName: bundleName // 打开指定应用的详情页面
      }
    }
    this.context.startAbility(wantInfo).then(() => {
      // ...
    }).catch((err) => {
      // ...
    })
  }

  async checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    let atManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus;

    // 获取应用程序的accessTokenID
    let tokenId: number;
    try {
      let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
    } catch (err) {
      console.error(`getBundleInfoForSelf failed, code is ${err.code}, message is ${err.message}`);
    }

    // 校验应用是否被授予权限
    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (err) {
      console.error(`checkAccessToken failed, code is ${err.code}, message is ${err.message}`);
    }

    return grantStatus;
  }
}



