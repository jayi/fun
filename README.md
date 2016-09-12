# fun

使用百度 APIStore 提供的接口实现的笑话大全，目前包含文本笑话和图文笑话两项。

# 实现概述

* 使用 Swift 语言实现
* 数据来源为百度 APIStore 提供的接口
* 网络请求使用的库是 Alamofire
* 刷新控件使用 MJRefresh
* 界面都为纯代码实现，使用 SnapKit(Masonry 的 Swift 版) 简化 Autolayout 代码
* 使用 YYWebImage(类似 SDWebImage, 功能更强大), 做图片解码和缓存
