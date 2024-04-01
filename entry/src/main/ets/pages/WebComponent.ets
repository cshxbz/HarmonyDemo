import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';
import web_webview from '@ohos.web.webview';

@Entry
@Component
struct WebComponent {
  private readonly logTag = "WebComponent"
  private context = getContext(this) as common.UIAbilityContext;

  webviewController: web_webview.WebviewController = new web_webview.WebviewController();

  aboutToAppear() {
    // 配置web开启调试模式
    web_webview.WebviewController.setWebDebuggingAccess(true);
  }

  build() {
    Column() {
      Web({ src: 'http://192.168.20.218:8080/', controller: this.webviewController})
        .domStorageAccess(true)
    }
    .width('100%')
    .height('100%')
    // .padding({bottom:100})
    .backgroundColor('#c0c0c0');
  }
}

