# README

[Travel World website](https://www.travelworld.cf/)


## Getting Started
1. Ruby gem Install
```
bundle install
```

2. Setup database
```
rails db:migrate
rails db:seed
```
3. Setting API info with .env file
Travel_world/.env


## ERD
![](https://i.imgur.com/jfbr3kY.jpg)


## Built With
Rails 5.1.5

pg 0.20

Google Map API

Google Places API Web Service

Bootstrap 4


## Deployment
Google Cloud Platform

Amazon S3

## Authors
[Zarek Chung](https://github.com/ZarekChung)

[Yass](https://github.com/BJ0815)

[Cindy Liu](https://github.com/cindyliu923)

## User Stories

#### 1.會員註冊登入登出

- 使用者可以透過FB/Google登入網站
- 會員可以複製/收藏網站上的行程，在我的行程查看自己的行程以及收藏/評論/被複製的行程
- 非會員只能使用網站規劃行程的服務，最後可以顯示查看，但不能儲存



#### 2.規劃行程

- 設定旅遊日期天數(目前最多為3天)、地點

- 填寫行程表
    1. 預設帶入使用者輸入的地區，找出推薦的景點
    2. 使用者可以透過自動完成找出想要搜尋的地點資訊，並針對類別去做搜尋
    3. 點選景點可觀看景點的照片輪播
    4. 使用者點選顯示地圖按鈕可同時在地圖上看到目前已加入的行程
    5. 規劃行程右方顯示使用者目前已加入的景點，將行程去做ＣＲＵＤ動作，若有修改即時更新
    6. 使用者可以選定特定或全部的景點進行交通路線規劃  --in progress
    7. 使用者可以以拖拉的方式調動景點，調整順序
    8. 使用者新增景點時，系統會判斷預計的時間是否超過營業時間  --in progress
    9. 手機版瀏覽時地圖以清單呈現  --in progress

 - 輸入飯店機票資訊
     1. 輸入飯店名稱會自動帶入地址
     2. 輸入機票代號會自動填入班機時間  --in progress
 - 使用者可以將行程表發送至信箱   --in progress

#### 3.行程複製功能

- 當複製別人的行程時，被複製的使用者會紀錄誰複製了你的行程並且新增積分
- 複製行程後可針對行程進行編輯

#### 4.搜尋行程

- 使用者可以搜尋目前網站所建立的行程，並收藏或複製
- 搜尋可針對收藏數以及評論數去做排序
- 使用者可以針對瀏覽的行程留下評論/檢舉/評分
-
#### 5.會員資料

- 查看目前收藏/分享/被複製的行程總數
- 查看積分狀態，分享行程得1分，如被人別複製得2分
- 使用者可以編輯自己的個人資料


#### 6.admin
- 管理者可以設定使用者權限
- 管理者可以針對停權得行程進行放行/刪除

#### 7.其他
- 使用者可以切換語系  --in progress
- 測試  --in progres
