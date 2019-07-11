---
layout: post
title: "[筆記]Linux中使用shell將pdf轉檔"
date: 2019-07-11 16:20:16 +0800
categories: jekyll update
tags: [Linux]
---

# 事件
彰中新生報到當天會使用app掃描QRCode檢查是否完成各項資料填報，<br>
而今年必須加入各處室的帳號，供其檢視各別處室所需事項之功能。<br>
而出納組必須檢查新生是否完成個人銀行帳號的填報及存摺影本。<br>
存摺影本開放上傳.jpg檔及pdf檔，而將pdf檔顯示在網頁上是容易的事。<br>
但因本次需要在app中檢視，而ai2編寫出的app中的瀏覽器卻不支援pdf的plugin。<br>
重點是！在編寫這部份程式碼時已經開放資料上傳、填報，因此無法限制上傳檔案。<br>

查了一些資料，ai2編寫的app似乎在這方面是無解，<br>
無法更改客戶端環境的情況下，只好暫時在今年修改伺服端，<br>
將所有pdf檔轉檔程jpg檔。<br>
我選擇了使用ImageMagick這套強大的圖片處理工具。<br>
可使用`convert`轉檔指令。<br>

# 安裝ImageMagick工具
彰中伺服器全部為CentOS 6，使用yum即可安裝。
```shell
	yum install ImageMagick ImageMagick-devel
```

#使用convert指令
```shell
	convert -density 300 input.pdf -quality 90 output.jpg
```
-density參數設定輸出檔的每英吋點數（dpi）<br>
-quality參數設定圖片壓縮層級<br>
convert指令若遇到多頁的pdf檔，會自動從0開始編碼並生成圖檔(ex: output-0.jpg)<br>
這部份需注意名稱的變換，在後面寫shell的時候因為這個撞牆很久，一直找不到我要的檔。

# 使用shell自動化處理大量資料
因為系統已經開放上傳兩天，資料量已經非常龐大，<br>
我不可能人工一個一個慢慢convert，<br>
因此前不久學的shell指令可以派上用場，讓電腦自動化幫我工作。

## 找出pdf檔
因為pdf、jpg混在一起，因此要先找出pdf檔建表，<br>
等等只要從表裡找目標物就可以開始處理了。<br>
我使用find指令將所有pdf檔案寫入pdf_file.out文字檔中。
```shell
	find *.pdf > pdf_file.out
```
## 列表
讓使用者先知道清單中有哪些需要更改，<br>
其實這有點無用，但就當作練習shell吧！<br>
用迴圈讀取每一行
```shell
	filename="pdf_file.out"
	for line in `cat $filename`
	do
		echo $line
	done
```
## 處理文件
我有加了確認的步驟，雖然好像有點無用，<br>
不過這讓我可以比較安心一點，畢竟這是在正在運作的伺服器上。
```shell
	read -p "Please input (Y/N): " choise
	if [ $choise == "Y" ]||[ $choise == "y" ] ;then
		echo "Yes"
		for line in `cat $filename`
		do
			out=${line:4:10}.jpg
			echo $out
			convert -density 300 $line -quality 90 $out
			mv $out 108/
			mv $line pdfbk/
		done
		else
			echo "No"
	fi
```
講其中一段
```shell
	out=${line:4:10}.jpg
	echo $out
	convert -density 300 $line -quality 90 $out
	mv $out 108/
	mv $line pdfbk/
```
`out=${line:4:10}.jpg`因取得的檔案名稱為108/N111222333.pdf格式<br>
需取得N111222333十字，因此由4號往後數10，並把副檔名設成jpg<br>
並使用convert指令轉檔，最後將輸出檔移至所需位置，<br>
並把原pdf檔移至pdfbk留存備份。

# pdf.sh總文件
```shell

# 編寫者：snsd0805<levi900227@gmail.com>
# 用途：新生報到bank圖檔 由pdf轉jpg
# 原因：雖電腦瀏覽器可以瀏覽pdf檔，然而app端因ai2網頁瀏覽器不支援pdf相關plugin，因此需要先轉檔使用
echo "新生報到銀行pdf轉jpg"
echo "讀取pdf檔..."
echo "寫入pdf_file.out..."
sleep 2
find 108/*.pdf > pdf_file.out

echo "以下為清單列表"

filename="pdf_file.out"
#exec<$filename
for line in `cat $filename`
do
    echo $line
done
echo ""
echo "按Y/n確認是否轉換並備份原檔至studentreg2019"
read -p "Please input (Y/N): " choise
if [ $choise == "Y" ]||[ $choise == "y" ] ;then
    echo "Yes"
    for line in `cat $filename`
    do
	out=${line:4:10}.jpg
	echo $out
	convert -density 300 $line -quality 90 $out
	mv $out 108/
	mv $line pdfbk/
    done
else
    echo "No"
fi
echo "完成"
```
雖然很大部份寫了無用的程式碼，然而當作練習也不錯<br>
第一次使用shell幫助工作讓我很興奮呢！
# 結束
