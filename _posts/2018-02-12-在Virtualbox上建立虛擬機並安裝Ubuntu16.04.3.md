---
layout: post
title:  "在Virtualbox上建立虛擬機並安裝Ubuntu16.04.3"
date:   2018-02-12 19:20:00 +0800
categories: jekyll update
tags: [linux,研習,virtualbox,ubuntu,]
---

在2017年12月23日架好這個網頁以後再也沒有動過了XD<br><br>
這幾天剛好要幫學弟辦研習講Linux系統和php和MySQL資料庫<br> <br> 
	<img src="/images/csvt.jpg"><br><br>
所以最近會發幾篇關於這部份的東西！！！<br> <br>
<!-- more -->
順便給沒到的學弟自己學學看，然後有來的學弟可以再複習一下<br> <br> 
<br> <br> 

# 本次研習重點
## 第一天
+ 講解LAMP架構<br> <br>  
+ 使用虛擬機virtualbox架設linux伺服器<br> <br>  
+ Linux基本指令操作<br> <br>  
+ PHP語法介紹<br> <br>  
+ HTTP協定 POST&GET<br> <br>  

## 第二天
+  實作PHP登入系統<br> <br> 
+  終端機操作MySQL資料庫<br> <br> 
+ 使用phpmyadmin操作資料庫<br> <br> 
+ 以MySQLi實現網頁與資料庫的連結<br> <br> 
+ 實作PHP&MySQL登入系統<br> <br> 
<br> <br> 
總之就是用虛擬機架設Linux系統的伺服器<br> <br> 
並且學習基本Linux指令和php語言以及MySQL資料庫<br> <br> 
<br> <br> 

# 萬事起頭難，建立好虛擬機環境
1. 一開始我們就要先安裝好[Virtualbox虛擬機器軟體](https://www.virtualbox.org/)https://www.virtualbox.org/<Br><br>
		可以在這軟體上建立一個新的環境，且不與主電腦發生衝突。<Br><br>
		到官網選擇大大的Downlod後選擇自己的作業系統下載，安裝過程在此不加贅述。<BR><BR>
		<a href="/images/擷取選取區域_003.png" >
		<img src = "/images/擷取選取區域_003.png"  ></a><br><br><br><br>
2. 開啟Virtualbox<br><br>
		<a href="/images/擷取選取區域_004.png" >
		<img src = "/images/擷取選取區域_004.png"  ></a><br><br><br><br>

3. 點選新增，準備建立一個虛擬機環境<br><br>
		<a href="/images/擷取選取區域_005.png" >
		<img src = "/images/擷取選取區域_005.png"  ></a><br><br><br><br>

4. 建立虛擬機器<br><br>
	1. 名稱和作業系統 <BR><BR>
		名稱可自行命名，不影響實作結果。<br><br>
		本次我們將使用Linux家族的Ubuntu 16.04發行版本<br><br>
		因此在類型選取Linux<br><br>
		而版本部份我們選取Ubuntu(64-bit)<br><br>
		<a href="/images/擷取選取區域_006.png" >
		<img src = "/images/擷取選取區域_006.png"  ></a><br><br><br><br>
	2. 記憶體大小<BR><BR>
		此處可依個人需求而更改，在此我依預設值（1024 MB）設定<br><br>
		<a href="/images/擷取選取區域_007.png" >
		<img src = "/images/擷取選取區域_007.png"  ></a><br><br><br><br>
	3. 硬碟<BR><BR>
		因為虛擬機器是在主電腦上建立一個新的機器環境，<br><br>
		因此仍然要分配硬碟空間(筆者使用Virtualbox磁碟映像的檔案類型)給它運作，<br><Br>
		Linux是個耗費資源非常少的系統，<br><br>
		其實在一顆USB上就可以安裝了<BR><BR>
		因此我只分配10GB給它<br><br>
		<a href="/images/擷取選取區域_008.png" >
		<img src = "/images/擷取選取區域_008.png"  ></a><br>
				在此處選擇要建立虛擬硬碟<br><br><br>
		<a href="/images/工作區 1_009.png" >
		<img src = "/images/工作區 1_009.png"  ></a><br>
				選取VDI(Virtualbox磁碟映像)格式<br><br><br>
		<a href="/images/擷取選取區域_010.png" >
		<img src = "/images/擷取選取區域_010.png"  ></a><br>
				選取動態配置<br><br><br>
		<a href="/images/擷取選取區域_011.png" >
		<img src = "/images/擷取選取區域_011.png"  ></a><br>
				分配空間<br><br><br><br>
	**好！那麼等等就是要開始安裝linux系統了！**<br><br><br><br>

# 安裝Ubuntu16.04.3在虛擬機 
如果你還不知道什麼是Linux，<br><br>
可以到我寫的另外一篇文章：[Linux是什麼？可以吃嗎？](https://snsd0805.github.io//jekyll/update/Linux%E6%98%AF%E4%BB%80%E9%BA%BC-%E5%8F%AF%E4%BB%A5%E5%90%83%E5%97%8E/)看看<br><br>
那我們開始囉！！<br><br><br><br><br><br>
1. 下載Linux光碟映像檔
		今天要安裝的系統是Linux家族的Ubuntu 16.04.3 LTS版本，<br><br>
		先到官網的[下載頁面](https://www.ubuntu.com/download/desktop)
		https://www.ubuntu.com/download/desktop 下載<br><br>
		<a href="/images/擷取選取區域_013.png" >
		<img src = "/images/擷取選取區域_013.png"  ></a><br><br><br><br>
		在此說明一下Ubuntu的版本，<br><br>
		Ubuntu在同一個主要版本會發行兩個版本，<br><br>
		以Ubuntu16來說，<Br><br>
		就有16.04 LTS 和 16.10兩種版本，<BR><BR>
		眼尖的人應該有發現04版本比10版本後面多了LTS一字<BR><BR>
 		LTS指的是Long Term Support（長期支援）<Br><br>
		針對Desktop版本提供3年的更新服務<BR><BR>
		而Server版本提供長達5年的更新服務<BR><BR>
		而選擇何種版本，請依自己需求而挑選<br><br>
		<a href="/images/擷取選取區域_014.png" >
		<img src = "/images/擷取選取區域_014.png"  ></a><br>
		可以直接選左邊選項的Not now, take me to the download<br><br>
		或者也可以選右邊用PayPal贊助給開發者們！<br><br>
		下載後應該就會得到一個名為 
		```
			ubuntu-16.04.3-desktop-amd64.iso
		```
		的光碟映像檔。<BR><BR><BR>
		
2. 開啟虛擬機器
		將剛剛新增好的虛擬機器開啟<br><br>
		<a href="/images/擷取選取區域_026.png" >
		<img src = "/images/擷取選取區域_026.png"  ></a><br><br><br><br>
		開啟後會要求你選擇開機的磁碟，請選擇剛剛下載下來的iso檔<br><br>
		<a href="/images/擷取選取區域_027.png" >
		<img src = "/images/擷取選取區域_027.png"  ></a><br><br><br><br>
		成功開啟後就會進到這個畫面，<br><br>
		你可以先選擇繁體中文<br><br>
		<a href="/images/擷取選取區域_028.png" >
		<img src = "/images/擷取選取區域_028.png"  ></a><br><br><br><br>
		有兩個選項可以選擇，<br><br>
		如果你只想要玩玩看ubuntu可以選擇「試用ubuntu」<br><br>
		不過本篇文章是要安裝所以我再這裡選右邊<a href="/images/擷取選取區域_029.png" >
		<img src = "/images/擷取選取區域_029.png"  ></a><br><br><br><br>
		接著會有安裝前的準備選項可以選取，請依個人需求選擇<br><br>
		<a href="/images/擷取選取區域_030.png" >
		<img src = "/images/擷取選取區域_030.png"  ></a><br><br><br><br>
		接著是選擇安裝的類型，為了方便我選擇清除磁碟並安裝ubuntu<br><br>
		這部份不用擔心會刪除到電腦裡的資料，因為這是虛擬機器所以不會影響到你的主電腦<br><br>而其他選項有興趣的話可以自行搜尋一下，本篇文章不再此敘述<br><br>
		<a href="/images/擷取選取區域_031.png" >
		<img src = "/images/擷取選取區域_031.png"  ></a><br><br><br><br>
		接著會有一連串的系統設定，第一部份是選擇所在時區<br><br>
		它是可以點選地圖來選擇，非常的酷！<br><br>
		<a href="/images/擷取選取區域_032.png" >
		<img src = "/images/擷取選取區域_032.png"  ></a><br><br><br><br>
		接著是選擇鍵盤排列方式，如果不確定的話可以直接按繼續或者選取左下角的偵測鍵盤配置		<br><br>
		<a href="/images/擷取選取區域_033.png" >
		<img src = "/images/擷取選取區域_033.png"  ></a><br><br><br><br>
		最後就是設定名稱密碼等等<br><br>
		<a href="/images/擷取選取區域_034.png" >
		<img src = "/images/擷取選取區域_034.png"  ></a><br><br><br><br>
		這部份有必要解釋一下，<br><br>
		使用者名稱是使用者可以用來登入的帳號<br><br>
		在windows系統底下也有類似的東西<br><br>
		而電腦名稱則是再連線時其他裝置看到你的電腦的名稱<br><br>
		而這部份也可以打開終端機的時候看到<br><br>
		<a href="/images/擷取選取區域_035.png" >
		<img src = "/images/擷取選取區域_035.png"  ></a><br><br>
		小老鼠(@)前面的snsd0805是我的使用者名稱<br><br>
		小老鼠(@)後面的SNSDFOREVER則是我的電腦名稱<BR><br><br><BR>
		接著就會進入安裝程序，速度依硬碟速度而不同，可以先去泡杯咖啡等候一陣子<br><br><a href="/images/擷取選取區域_036.png" >
		<img src = "/images/擷取選取區域_036.png"  ></a><br><br><br><br>
		<br><br>
		安裝過程結束以後就可以重新啟動虛擬機開始使用ubuntu拉！！<br><br>
		<a href="/images/擷取選取區域_037.png" >
		<img src = "/images/擷取選取區域_037.png"  ></a><br><br><br><br>
如果1內容有誤或有疑惑者還請與我聯繫<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="https://twitter.com/sone900227"><img src="/images/twitter_icon.png" width="40" height="40"></a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="mailto:levi900227@gmail.com"><img src="/images/Gmail_Icon.png" width="40" height="40">



	
