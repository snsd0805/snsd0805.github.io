---
layout: post
title: "[筆記]Virtual function"
date: 2019-06-29 21:04:29 +0800
categories: jekyll update
tags: [c++]
---
# 事件
最近跟中二中的智仁學弟重構布丁學弟的Puddings_Dragon，<br>
就是個勇者鬥惡龍的c++遊戲，<br>
以前就覺得應該是很多if else的小遊戲吧！ 結果看完程式碼...<br>
還真的是一大堆的if else，到底哪裡來的耐心寫出來的XD<br>

最近寫到skill的部份，用Fire、Hide等繼承skill父類別，<br>
然而呼叫子類別的use()時竟然只能呼叫父類別的use()，<br>
求助PTT C_AND_CPP版後找到關鍵字 Virtual Function。<br>
寫太久php，只記得C++沒有abstract、interface，完全忘記有virtual。<br>
# 原code
Skill是父類別，規範子類別需有use()<br>
Fire繼承Skill，Override覆寫 use()
```cpp
	class Skill
	{
	public:
    	void use(){...A...}
	}

	class Fire : public Skill
	{
	public:
    	void use(){...B...}
	}
```
<br>
我用一個新的類別Skill_List將擁有的skill串起來方便程式使用
```cpp
	class Skill_List()
	{
	public:
    	Skill_List(){
        	this->skill[0]=new Fire;
        	this->skill[1]=new Hide;
    	}
	private:
    	Skill *skill[2]
	}
```
<br>
然而欲使用skill[0]的use()時，<br>
執行的卻不是子類別Fire裡的use() B動作，而是父類別的A動作<br>
我很困惑的是我儲存的列表明明是用指標存，但是為什麼會出現不屬於Fire類別的動作<br>
```cpp
	Skill_List list;
	list.skill[0]->use(); 
```
# Virtual Function
Virtual Function可以實現「執行時期」的多型支援，是一個「晚期繫結」（Late binding）、「動態繫結」（Dynamicbinding）
<br>
反之，Overloading在編譯時期就決定，
是「早期繫 結」（Early binding）、「靜態繫結」（Static binding）
<br>

## 事件出事點
先了解以下code是可行的
```cpp
	//Fire 繼承 Skill
	
	Skill *sptr;
	Fire f;
    sptr = &f;
```
然而sptr被宣告為Skill類別，因此只能存取Skill的成員方法，
這就是原code中最後`list.skill[0]->use()`只能使用父類別成員方法的原因。

## 所以？
Virtual finction是在父類別就用virtual宣告，到了子類別再重新定義。<br>
而父類別指標變不能使用virtual宣告的成員方法，<br>
便可以子類別中的Virtual finction。<br>
該目的是將操作決議延遲到執行時期才決定。<br>
<br>
因此這在實現設計模式中工廠模式的工廠和產品時可以使用到，<br>
將factory & product的成員方法宣告為virtual，<br>
到了各產品定義時才定義成員方法的內容。<br>
# 結束
