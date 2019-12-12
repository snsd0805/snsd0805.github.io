---
layout: post
title: "[筆記] 更新linux kernel小記"
date: 2019-12-12 23:10:09 +0800
categories: jekyll update
tags: [linux]
---

# 寫在前面

最近用`pacman`安裝套件時，曾直接下`sudo pacman -Syu`指令升級所有套件。

結束後重啟電腦後竟然造成後續其他新增的套件執行錯誤。



※ 以下問題點論述可能不正確，仍待與專業人士討論

google爬文後發現可能是pacman在更新全套件時已經將linux kernel更新，故後續所新增的其他套件都是以新kernel之相依性作考慮，

然而我沒有注意到已經將kernel更新，因此新套件的相依性與舊kernel出現問題，因此無法正常執行。

### 確認問題發生點

確認目前執行的kernel

```
uname -r
linux-lts 4.19.88-1    # 顯示結果
```

確認最新安裝kernel

```
sudo pacman -Q linux
```

# 解決

以前真的沒有更動linux kernel的經驗，

因為我覺得每次重新安裝linux都是一個痛苦的開始，實在不敢拿常用機來實驗。

也因此許多很簡單的事情都沒有想到。

而因為這次是意外引起，

既然已經更新了那就硬著頭皮嘗試換成新kernel，以下直接紀錄要更新kernel的方法。

### pacman更新linux kernel

官方支援的kernel有四種

1. `linux`：**Stable** — Vanilla Linux kernel and modules, with a few patches applied.

2. `linux-hardened`：**Hardened** — A security-focused Linux kernel applying a set of hardening patches to mitigate kernel and userspace exploits. It also enables more upstream kernel hardening features than `linux`.

3. `linux-lts`：**Longterm** — Long-term support (LTS) Linux kernel and modules.

4. `linux-zen`：**Zen Kernel** — Result of a collaborative effort of kernel hackers to provide the best Linux kernel possible for everyday systems. Some more details can be found on [https://liquorix.net](https://liquorix.net/) (which provides kernel binaries based on Zen for Debian).

以上資料取自arch wiki

```
sudo pacman -S linux-lts
```

### 讓grub可重新引導至新kernel

```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### reboot

reboot後grub選單可以選擇新的kernel（在linux advanced裡）

### 確認kernel版本

```
uname -r
```



# 教訓

>   Warning:
> 
> - Users are expected to follow the guidance in the [System maintenance#Upgrading the system](https://wiki.archlinux.org/index.php/System_maintenance#Upgrading_the_system "System maintenance") section to upgrade their systems regularly and not blindly run the following command.
> 
> - **警告:** 並不是每當更新可用時就得馬上更新。使用者必須瞭解，基於 Arch 的「無縫更新」特性，每一次大更新都可能會導向無法預期的結果。打個比方而言，在您準備一場重要的演說前一刻更新系統是相當不智的行為。最好在閒暇時刻進行更新，並準備應付更新可能引發的任何問題。
> 
> 取自Archlinux wiki/pacman



# 寫在後面

寫完後覺得出問題的地方仍然還有疑惑，對於前述查到出問題的地方似乎又與我理解的pacman特性有衝突，因此對於該資料我仍採保留態度，希望可以在網路上找到更多相關資料，或者會找個時間去moli實驗室找人求救。



另外關於grub選單的問題，因為ubuntu裡更新kernel似乎會把預設選項設成最新的kernel版本，在arch linux裡則是要手動修改grub參數。

### 確認Default開機選項

以下結果代表預設開機選項是使用第0個menuentry，一個menuentry代表一個開機選項。

```
cat /etc/default/grub | grep GRUB_DEFAULT
GRUB_DEFAULT=0    # 結果
```

### 找到欲更改的menuentry

到grub.cfg裡找到要使用的menuentry

自行將齊移動到第0號位置。

```
cat /boot/grub/grub.cfg
```

### 更新grub

```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```


