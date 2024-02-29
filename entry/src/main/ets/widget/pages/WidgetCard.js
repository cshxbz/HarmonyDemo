"use strict";
struct WidgetCard extends   {
    constructor() { }
    build() {
            .width('100%')
            .height('100%')
            .backgroundColor('#c0c0c0');
    }
    // @Builder
    // ToolItem(text: string) {
    //   Text(text)
    //     .width('100%')
    //     .height('100%')
    //     .backgroundColor(Color.White)
    //     .borderRadius(10)
    // }
    postCardActionToJumpPage(pageUrl) {
        postCardAction(this, {
            'action': 'router',
            'abilityName': 'EntryAbility',
            'params': {
                'targetPageUrl': pageUrl // 在EntryAbility中处理这个信息
            }
        });
    }
}
struct ToolItem extends  {
    constructor() { }
}
//# sourceMappingURL=WidgetCard.js.map