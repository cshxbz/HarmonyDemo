import hilog from '@ohos.hilog'

export namespace logUtil {

  const GLOBAL_TAG = "GLOBAL_TAG";
  const COMMON_FORMAT = "%{public}s";

  export function i(tag: string = GLOBAL_TAG, message: string) {
    hilog.info(0x0000, tag, COMMON_FORMAT, message)
  }

  export function e(tag: string = GLOBAL_TAG, message: string) {
    hilog.error(0x0000, tag, COMMON_FORMAT, message)
  }

  export function w(tag: string = GLOBAL_TAG, message: string) {
    hilog.warn(0x0000, tag, COMMON_FORMAT, message)
  }

}