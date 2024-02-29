import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import socket from '@ohos.net.socket';
import { logUtil } from 'app_base_lib/src/main/ets/utils/LogUtil';
export default class EntryAbility extends UIAbility {
    constructor() {
        super(...arguments);
        this.logTag = "EntryAbility";
        this.logFormat = "%{public}s";
        this.targetPageUrl = null;
        this.currentWindowStage = null;
        this.tcpSocket = null;
    }
    onCreate(want, launchParam) {
        logUtil.i(this.logTag, "onCreate");
        this.context.eventHub.on('custom_event', (...data) => {
            let strArr = data;
            hilog.info(0x0000, this.logTag, this.logFormat, strArr.toString());
        });
        this.parseTargetPageByWant(want);
    }
    testFun() {
    }
    onNewWant(want, launchParam) {
        logUtil.i(this.logTag, "onNewWant");
        this.parseTargetPageByWant(want);
        this.loadContentByTargetPage(this.currentWindowStage);
    }
    parseTargetPageByWant(want) {
        if (want.parameters.params === undefined) {
            logUtil.i(this.logTag, "parseWantToLoadContent -- want.parameters.params === undefined");
            return;
        }
        let params = JSON.parse(want.parameters.params);
        this.targetPageUrl = params.targetPageUrl;
    }
    loadContentByTargetPage(windowStage) {
        let shouldLoadPageUrl = null;
        if (this.targetPageUrl !== null && this.targetPageUrl !== undefined) {
            shouldLoadPageUrl = this.targetPageUrl;
        }
        else {
            shouldLoadPageUrl = 'pages/MainPage';
        }
        if (windowStage === null && windowStage === undefined) {
            logUtil.i(this.logTag, 'windowStage === null && windowStage === undefined');
            return;
        }
        logUtil.i(this.logTag, `>>>> shouldLoadPageUrl: ${shouldLoadPageUrl}`);
        windowStage.loadContent(shouldLoadPageUrl, (err, data) => {
            if (err.code) {
                logUtil.i(this.logTag, `loadContent -- failed ${err}`);
                return;
            }
            logUtil.i(this.logTag, `loadContent -- success ${err}`);
        });
    }
    onDestroy() {
        logUtil.i(this.logTag, "onDestroy");
    }
    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        logUtil.i(this.logTag, "onWindowStageCreate");
        this.loadContentByTargetPage(windowStage);
        this.currentWindowStage = windowStage;
    }
    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        logUtil.i(this.logTag, "onWindowStageDestroy");
    }
    onForeground() {
        // Ability has brought to foreground
        logUtil.i(this.logTag, "onForeground");
    }
    onBackground() {
        // Ability has back to background
        logUtil.i(this.logTag, "onBackground");
    }
    async socketSendMessage() {
        logUtil.i(this.logTag, "send start");
        try {
            await this.tcpSocket.send({
                data: 'abc',
                encoding: 'utf-8'
            });
        }
        catch (e) {
            logUtil.i(this.logTag, `send error : ${e}`);
        }
        logUtil.i(this.logTag, "send end");
    }
    createTCPSocketConnect() {
        // 创建TCPSocket
        this.tcpSocket = socket.constructTCPSocketInstance();
        // 订阅TCPSocket相关的订阅事件
        this.tcpSocket.on('message', value => {
            logUtil.i(this.logTag, 'on message');
            let buffer = value.message;
            let dataView = new DataView(buffer);
            let str = "";
            for (let i = 0; i < dataView.byteLength; ++i) {
                str += String.fromCharCode(dataView.getUint8(i));
            }
            logUtil.i(this.logTag, "on connect received:" + str);
        });
        this.tcpSocket.on('connect', () => {
            logUtil.i(this.logTag, 'on connect');
        });
        this.tcpSocket.on('close', () => {
            logUtil.i(this.logTag, 'on close');
        });
        this.tcpSocket.bind({
            address: 'localhost', family: 1, port: 8765
        }, (err, data) => {
            logUtil.i(this.logTag, `tcpSocket.bind err: ${err}} data: ${data}}`);
        });
    }
}
//# sourceMappingURL=EntryAbility.js.map