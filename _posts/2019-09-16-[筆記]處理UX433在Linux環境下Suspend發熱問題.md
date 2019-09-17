---
layout: post
title: "[筆記]處理UX433在Linux環境下Suspend發熱問題"
date: 2019-09-16 22:34:51 +0800
categories: jekyll update
tags: [linux]
---

# 問題

暑假剛換了筆電UX433，然而裝了Arch linux以後卻發現了一個問題，那就是當電腦處於suspend狀態下，竟然只停掉了風扇，然而CPU之類的硬體似乎還在運行，導致暫停後的電量狂掉，而且有嚴重過熱的狀況發生。

為了省電，並且過熱怕影響硬體壽命，因此使用後都馬上關機，等需要使用才重新開機。雖然SSD開機很快，然而還是會浪費不少時間，另外也怕反覆的開關機會影響筆電壽命。因此一直在找解決方法。

找了一些資訊，然而卻一直找不到相關資訊，最近幾天才終於找到[一篇文章](https://rephlex.de/blog/2018/08/21/asus-zenbook-13-ux331un-with-ubuntu-battery-drain-while-in-suspend/%5D)有解決方法，才發現看來是我自己下英文關鍵字的能力太差了，仍待加強QQ。

因為怕原網址刪除或者下次找不到，所以自己理解過然後作個紀錄。有看到這篇的大家也可以去[原作者的網站](https://rephlex.de/blog/)看看一些實用有趣的文章。

# 問題分析

以下為原作者之使用方式

首先，查詢系統日誌並搜尋出最近兩筆的suspend紀錄

```
    sudo journalctl | grep "PM: suspend" | tail -2
```

以下是我的日誌搜尋結果，其中s2idle的意思就是Suspend-to-idle，雖然會暫時停止使用者的作業環境、將I/O設備切換至低功率狀態，然而仍然不是我們所需的理想狀態。

關於前述的Suspend-to-idle屬於四種System sleep state中的其中一種，詳細可以看[這篇](https://www.kernel.org/doc/html/v4.15/admin-guide/pm/sleep-states.html)

```
 9月 16 23:23:12 snsd-arch kernel: PM: suspend entry (s2idle)
 9月 16 23:52:26 snsd-arch kernel: PM: suspend exit
```

或者也可以直接查詢sleep state的設定檔

```
    cat /sys/power/mem_sleep
```

以下內容代表sleep state預設為s2idle

```
[ s2idle] deep
```

# 修改

修改grub bootloader的設定檔

建議先進入資料夾備份grub設定檔

```
    cd /etc/default/
    sudo cp grub grub.bk
```

備份完後修改grub設定檔

```
    sudo vim grub
```

找到GRUB_CMDLINE_LINUX_DEFAULT並且增加`mem_sleep_default=deep`在雙引號內

```
    GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet mem_sleep_default=deep"
```

    產生新的grub.cfg設定檔，並重新開機

```
    grub-mkconfig -o /boot/grub/grub.cfg
    reboot
```

# 結束

修改上述內容後，系統進入暫停模式就會進入deep的休息模式，將運行內容減到最低，再也不會有電腦發燙的問題了！
