import hilog from '@ohos.hilog';
export var logUtil;
(function (logUtil) {
    const GLOBAL_TAG = "GLOBAL_TAG";
    const COMMON_FORMAT = "%{public}s";
    function i(tag = GLOBAL_TAG, message) {
        hilog.info(0x0000, tag, COMMON_FORMAT, message);
    }
    logUtil.i = i;
    function e(tag = GLOBAL_TAG, message) {
        hilog.error(0x0000, tag, COMMON_FORMAT, message);
    }
    logUtil.e = e;
    function w(tag = GLOBAL_TAG, message) {
        hilog.warn(0x0000, tag, COMMON_FORMAT, message);
    }
    logUtil.w = w;
})(logUtil || (logUtil = {}));
//# sourceMappingURL=LogUtil.js.map