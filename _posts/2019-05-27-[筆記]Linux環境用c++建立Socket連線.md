---
layout: post
title:  "[筆記]Linux環境用c++建立Socket連線"
date:   2019-05-27 11:30:00 +0800
categories: jekyll update
tags: [C++,通訊,Socket]
---
跟指導老師聊到學校伺服器的配置管理<br>然後就問他伺服器之間的通訊協定<br>
聊完覺得對通訊這部份有興趣，所以就打算寫寫看Socket<br>
其實以前有用php玩過Socket連線<br>
當時是想用php收Arduino的訊號儲存到資料庫<br>
但是當時對Socket完全沒有概念，純粹只有找實作方法<br>
但是最後還是沒有實作出來，這次打算先簡單用c++實作簡單的TCP/IP連線<br><br>
<!-- more -->
第一次寫筆記型式的文章，想先強調幾點給有點進來的朋友<br>
1. 不保證所有資料全部正確，因為我的資料來源除了原文書籍、中文書籍，也有一些中英文非官方的網路文章。<br>
2. 筆記純粹給自己看，所以文字省略傳統邏輯、簡略，可能跳這跳那的<br><br><br>
3. 本次參考網頁：<br>
	[ITREAD01網頁 C++ Socket學習筆記](https://www.itread01.com/articles/1476615311.html)<br>
	[LinuxHowtos Sockets Tutorial](http://www.linuxhowtos.org/C_C++/socket.htm)<br>
	[楊凱州github網頁 TCP Socket 學習筆記 Programming0](http://zake7749.github.io/2015/03/17/SocketProgramming/)<br>
	[鳥哥的 Linux 私房菜](http://linux.vbird.org/linux_server/0110network_basic.php#tcpip_transfer_tcphand)<br>
4. 本次參考書籍：<br>
	Linux Socket Programming by Example ,(Warren Gay,2000/04/01)<br>
	UNIX Network Programming (W. Richard Stevens,1998/01/15)<br>
	
	
	
# 套接字(Socket)
### Socket概念
Socket是對TCP/IP的封裝及應用<br>
其本身不是協議，而是一個調用接口(API)<br>
可支援不同的傳輸層協議（TCP或UDP）<br><br>
應用層的資料傳輸需要網路層的TCP連線，其需要在相對應的同一TCP Port<br>
而為了區別各個不同的TCP連線，作業系統為TCP/IP提供Socket介面<br><br>
而Socket即所謂長連線（http屬於短連線），一旦client & server建立起連線將不會主動斷掉<br>
除環境因素可能影響連線：防火牆、任何方主機死機、網路斷線...等<br><br>
### 建立Socket連線
建立Socket連線至少需一對套接字，分別為ClientSocket及ServerSocket<br>
建立連線過程分為三步驟：<br>
1. 伺服器監聽：<br>
	ServerSocket不定位特定的具體ClientSocket，而是處於等待連線狀態<br>
2. 客戶端請求：<br>
	ClientSocket提出連線請求，目標為ServerSocket(指向ip + TCP port)<br>
3. 連線確認：<br>
	ServerSocket收到連線請求，建立執行序發送套接字描述，建立連線<br><br>
		
* * * 
# OSI 網路模型
全名為開放式系統互連通訊參考模型（Open System Interconnection Refereance Model, OSI）<br>
國際化標準組織（ISO）制定網路電腦互連的標準<br>
### 分層
* 第一層：實體層(Physical Layer)<br>
傳遞0,1訊號<br>
ex: hub, RJ45網路線<br>
* 第二層：資料鏈結層(Data-Link Layer)<br>
分兩部份：<br>
	1. 邏輯連結控制（Logical Link Control, LLC）：訊框(Frame)傳遞、流程控制<br>
	2. 媒介存取控制（Media Access Control ,MAC）: 定義傳輸媒體存取方式<br>
ex: 交換器<br>
※ 訊框(Frame)：封裝數位訊號成一組資料，其為資料訊框(Data Frame)<br>
* 第三層：網路層(Network Layer)<br>
定義網路路徑及定址，以IP協定為基礎<br>
觀念：IP Address+data=Packet<br>
ex: ADSL小烏龜、路由器<br>
* 第四層：傳輸層(Transport Layer)<br>
負責資料傳輸及控制，即處理封包順序、流量、偵錯<br>
ex: TCP、UDP
* 第五層：會議層(Session Layer)<br>
管理、設定通訊連接
ex: SQL
* 第六層：表達層(Presentation Layer)
 將資料轉換為receiver可接受的格式，處理轉碼、加解密等<br>
 * 第七層：應用層(Application Layer)
 處理應用程式，提供使用者網路服務<br>
 ex: 常用通訊協定：DHCP、FTP、HTTP<br>
 ex: 應用軟體：瀏覽器<br><br><br>
 待學習Keyword: DHCP,Switch,Router,PPP<br>
 
 * * * 
# 電腦網路通訊協定 TCP/IP
### 觀念
 封包格式為連接導向的TCP或非連接導向的UDP<br>
 並且儲存含IP的表頭，並傳送Packet<br><br>
 ※TCP: 完整協定，包含完整的連線過程：連線、傳送、結束<br>
 ※UDP: 未建立完整連線即傳送封包<br><br>
 TCP補充觀念：TCP兩端的host透過連線來確保封包的傳遞，並且跟中間任何的router等等結點(node)無任何關聯<br><br>
 
### TCP的三向交握
目的： 建立可靠的連線<br>
順序： <br>
1. 封包發起：<br>
		客戶端想要對伺服端連線時，必須送出連線封包。<br>
		隨機使用1個大於1024的port，並在TCP表頭當中帶有SYN的主動連線，並記下發給伺服端的序號(Sequence number = 10001)<br>
2. 封包接收與確認封包傳送 <br>
		伺服器接到這個封包，並且確定要接收這個封包後，就會開始製作一個同時帶有 SYN=1, ACK=1 的封包<br>
		其中那個 acknowledge 的號碼是要給 client 端確認用的，所以該數字會比(A 步驟)裡面的 Sequence 號碼多一號 (ack = 10001+1 = 10002)<br>
		那我們伺服器也必須要確認用戶端確實可以接收我們的封包才行，所以也會發送出一個 Sequence (seq=20001) 給用戶端，並且開始等待回應<br>
3. 回送確認封包<br>
		用戶端收到來自伺服器端的 ACK 數字後 (10002) 就能夠確認之前那個要求封包被正確的收受<br>
		接下來如果用戶端也同意與伺服器端建立連線時，就會再次的發送一個確認封包 (ACK=1) 給伺服器，亦即是 acknowledge = 20001+1 = 20002<br>
4. 最後確認<br>
		伺服器端收到帶有 ACK=1 且 ack=20002 序號的封包後，就能夠建立起這次的連線<br> 

* * *
# Linux環境下c++時實作socket連線
該段參考部份[楊凱州github網頁 TCP Socket 學習筆記 Programming0](http://zake7749.github.io/2015/03/17/SocketProgramming/)之程式碼
## socket()函數
使用`socket(int ,int ,int )`在kernel中建立一個socket，並傳回該socket的檔案描述符<br>
```c++
int socket(int domain, int type, int protocol);
```
### Domain
domain定義socket要在哪個領域溝通，以下列常用<br>

     * （1）AF_INET         IPv4因特網域 （兩台主機透過網路進行資料傳輸）
     * （2）AF_INET6        IPv6因特網域 （兩台主機透過網路進行資料傳輸）
     * （3）AF_UNIX         Unix域 （程序與程序間的傳輸）


### Type
定義socket傳輸手段，以下列常用<br>

    * （1）SOCK_STREAM     序列化的連接導向通訊。對應的protocol為TCP。
    * （2）SOCK_DGRAM      提供的是一個一個的資料包(datagram)。對應的protocol為UDP
    
### Protocol
設定socket的協定標準，一般來說都會設為0，讓kernel選擇type對應的默認協議。<br>

 
### Socket()函數回傳值Return Value
成功產生socket時，會返回該socket的檔案描述符(socket file descriptor)<br>
我們可以透過它來操作socket。若socket創建失敗則會回傳-1，<br>
```c++
//建立一個socket
#include <iostream>
#include <sys/socket.h>
using namespace std;

int main()
{
    int sockfd=0;
    sockfd=socket(AF_INET , SOCK_STREAM , 0);

    if (sockfd== -1){
        cout<<"Fail to create a socket.";
    }

    return 0;
}
```
## connect()函數
處理網路服務時，如TCP，ClientSocket需與ServerSocket建立連接<br>
TCP Client可以connect()函式與Server端建立連結<br>
```c++
    int connect(int sockfd, struct sockaddr_in  *server, int addr_len);  
```
### sockfd
sockfd即socket()函數之回傳值，為socket的描述符<br>

     * （1）AF_INET         IPv4因特網域 （兩台主機透過網路進行資料傳輸）
     * （2）AF_INET6        IPv6因特網域 （兩台主機透過網路進行資料傳輸）
     * （3）AF_UNIX         Unix域 （程序與程序間的傳輸）


### server
關於這個socket的所有信息<br>
`netinet/in.h`已經為我們定義好了一個struct `sockaddr_in`來儲存這些資訊<br>
```c++
 // IPv4 AF_INET sockets:
// IPv6參見 sockaddr_in6
struct sockaddr_in {
    short            sin_family;   // AF_INET
    unsigned short   sin_port;     // 儲存port number
    struct in_addr   sin_addr; 
    char             sin_zero[8];  // Not used, must be zero
};

struct in_addr {
    unsigned long s_addr;          // load with inet_pton()
};

```
<br>
以下為設定
```c++
struct sockaddr_in info;

bzero(&info,sizeof(info));	//初始化 將struct涵蓋的bits設為0
info.sin_family = PF_INET;	//sockaddr_in為Ipv4結構

info.sin_addr.s_addr = inet_addr("123.123.13.12");	//IP address

info.sin_port = htons(8080);


```
#### PF_INET ?<br>
AF = Address Family<br>
PF = Protocol Family <br>
AF_INET = PF_INET<br>
理論上建立socket時是指定協議，應該用PF_xxxx，設置地址時應該用AF_xxxx，但混用不會有太大問題<br>
#### inet_addr?
一般163.23.148.100這種ip地址為ASCII表示法<br>
用inet_addr轉為整數型式ip，其為binary data<br>
#### hton ?
網路端的字節序與本機端的字節序可能不一致
網路端總是用Big endian，而本機端卻要視處理器體系而定，使用的是Little endian。
htons()就是Host TO Network Short integer的縮寫，它將本機端的字節序(endian)轉換成了網路端的字節序

### addr_len
就是*server的大小<br>
### Return value
成功回傳0，失敗傳-1<br>


