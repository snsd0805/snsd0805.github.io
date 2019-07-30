---
layout: post
title: "[筆記]Arch Linux重新安裝grub"
date: 2019-07-30 19:00:26 +0800
categories: jekyll update
tags: [Linux]
---

# 筆電壞了QAQ
會有重新安裝grub的需求就是因為我的筆電壞了！！QQ<br>
突然BIOS讀不到我的SSD，拆機壞了一顆舊的HDD也是讀不到，<br>
因為過保了所以先送認識的維修廠商請他評估，結果推斷八九不離十是主機板故障...<br>
窮學生還沒有換電腦的打算阿...QAQ<br>
最後還是決定先送皇家估價，如果維修的價格還可以接受就請它再多努力一陣子吧...

送修之前因為重要的資料還沒有移出備份，所以就用舊的HDD把平常的主力SSD換下來，<br>
然而家裡的桌機卻無法進入我的SSD Arch linux系統，明明支援UEFI開機的，<br>
最後推斷應該必須重裝bootloader，也就是grub。<br>

# 怕.jpg
在以前剛接觸linux時，在安裝Ubuntu的時候常常遇到安裝grub失敗，<br>
那時候有個學長就建議我直接重新安裝系統吧！不然重裝bootloader很麻煩！！<br>
也因此一直有個印象就是重裝grub一定很麻煩，沒事我才不要做麻煩事咧！

然而這次另外一個學長回覆我的IG限時動態說重裝grub很簡單的，<br>
但因為隔一天有系統要上線，所以我實在沒有時間嘗試，<br>
於是又隔了一天，自己找了一些資料發現原來其實重新安裝grub很簡單！！<br>
只不過因為第一次嘗試，而且又是攸關開機磁區如此重要的地方，所以下指令還是怕怕的。

怕膽小的我下次遇到類似狀況又會害怕下指令，所以這裡紀錄一下過程。

# 過程
## 1. 使用live USB開機
因為原系統無法開機，所以需要藉由live usb開啟一系統，執行指令。<br>
可使用任一Linux發行版本之live usb進行開機。<br>
以下範例以Arch linux為例。

## 2. 查看硬碟分區狀態
使用fdisk指令查看目前掛載的硬碟之分區狀態，找到原系統所在分區。<br>
(需先取得root權限)
```shell
	fdisk -l
```
以我自己為例，可以找到我的系統在/dev/sda

>	sda1是/boot掛載區
>	sda2是swap
>	sda3是/根目錄掛載區

以下是CML顯示資訊，可作為參考
```
所用裝置      Start      結束      磁區   Size 類型
/dev/sda1      2048   1050623   1048576   512M EFI System
/dev/sda2   1050624  17827839  16777216     8G Linux swap
/dev/sda3  17827840 234441614 216613775 103.3G Linux filesystem

```
## 3. 掛載磁區
以下磁區位址(sda)為我的掛載狀況，需依個人狀況不同而定<br>
將根目錄(sda3)掛載至/mnt<br>
若有額外分割/boot(sda1)掛載至/mnt/boot<br>
(該動作一樣需先取得root權限)
```
	mount /dev/sda3 /mnt
	mount /dev/sda1 /mnt/boot
```
## 4. chroot到欲修復作業系統
切換已掛載的/mnt為CML根目錄
```
	arch-chroot /mnt
```
## 5. 安裝grub
首先可以使用指令`os-prober`讓它檢查是否有其他系統存在，<br>
若沒有可以省略該步驟。

Arch理論上在安裝系統時應該有安裝過該指令了，如果沒有可以直接使用pacman安裝
```
	pacman -Sy os-prober
	
	os-prober
```
檢查完後開始安裝grub，<br>
跟os-prober一樣Arch理論上在安裝系統時應該有安裝過該指令了，如果沒有可以直接使用pacman安裝
```
	pacman -Sy grub efibootmgr
	
	＃下面是efi的，legacy bios不能使用
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
	grub-mkconfig -o /boot/grub/grub.cfg
```
## 6. 卸載剛剛掛載的磁區
首先先離開使用的作業環境
```
	exit
```
卸載磁區
```
	umount /mnt
```
## 7. 重啟電腦
```
	reboot
```
# 完成
