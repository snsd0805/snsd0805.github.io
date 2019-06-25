title=""
postdate=""
tags=""
name=""

read -p "輸入標題：" title
read -p "輸入tags(,)：" tags

name=$(date +"%Y-%m-%d-")$title.md

echo "---" >> $PWD/_posts/$name
echo "layout: post" >> $PWD/_posts/$name
echo "title: \"$title\"" >>$PWD/_posts/$name
echo "date: $(date +"%Y-%m-%d %T") +0800" >> $PWD/_posts/$name
echo "categories: jekyll update" >> $PWD/_posts/$name
echo "tags: [$tags]" >> $PWD/_posts/$name
echo "---" >> $PWD/_posts/$name

 
#	---
#	layout: post
#	title:  "在Github上寫一個自己的靜態網頁"
#	date:   2017-12-23 19:20:00 +0800
#	categories: jekyll update
#	tags: [github, web]
#	---
