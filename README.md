# chedemo

A new Flutter project.

# ios端设置
设置URL Types 添加URL Schemes：chedemo Identifier: share.chedemo.com

# 安卓端设置
在androidManifest.xml 配置scheme：chedemo host：share.chedemo.com

# flutter代码介绍：
1.网页唤起app需要添加插件uni_links
2.在全局管理器share_mgr调用uni_links插件方法或得网页传值
3.本demo传值采用base64加密 以pass_info为参数名，解析时需先解密再json字符串转Map
4.参数介绍：open_type : 打开类型 0.内部界面 1.链接 page_id: 页码 url: 外部链接(webview实现)


