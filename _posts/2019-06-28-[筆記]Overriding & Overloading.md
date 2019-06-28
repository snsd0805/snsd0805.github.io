---
layout: post
title: "[筆記]Overriding & Overloading"
date: 2019-06-28 19:15:43 +0800
categories: jekyll update
tags: [c++]
---
最近在寫C++的東西，<br>
在查資料的時候，注意到兩個平常被我搞混的辭彙：<br>
「Overloading」、「Overriding」<br>
一直以來我其實懂這兩者的觀念，然而卻不記得這種觀念的名詞。<br>
我是屬於不記名詞派的工程師XD。<br>
<br>
最近因為在看C++ How to Program看到這兩個有點熟悉但又陌生的名詞，<br>
怕以後讀到書看到名詞又忘記，所以這裡自己簡易版記一篇。<br>

# Overloading 多載 
## 定義
在一個類別（class）定義多個名稱相同，然而參數（Parameter）不同的函數。<br>
而系統判斷要使用何者即由參數數量及型別不同而判斷。<br>
## 例子
```cpp
	class graph
	{
	public:
    	void print(int x){
			cout<<"一維圖形";		
    	}
    	void print(int x,int y){
			cout<<"二維圖形";		
    	}
    	void print(int x,int y,int x){
			cout<<"三維圖形";		
    	}
	}
```
## 特點
1. 簡化函式命名，不需記住許多function name，交給系統判斷<br>
2. 增加工作效率<br>

## 番外 ： Operator Overloading
前述有人稱為function overloading，<br>
有人將Operator Overloading運算子多載也劃在overloading範圍。<br>
因為功力不足，鮮少使用Operator Overloading，因此等書看熟一點再補充<br><br><br>
# Overriding (覆寫)
## 定義
一子類別繼承（Inheritance）父類別，然而改寫父類別已定義的方法。<br>
name、return type、parameter都必須相同，僅return的值可變。<br>
## 例子
```cpp
class man
{
public:
    void say(){
		cout<<"I'm a man.";
    }
}

class teacher : public man
{
public:
	void say(){
		cout<<"I'm a teacher.";	
	}
}
```
## 特點
1. 減少重複開發相同屬性的類別<br>
2. 使用工廠模式（自行領悟，有錯請糾正）

