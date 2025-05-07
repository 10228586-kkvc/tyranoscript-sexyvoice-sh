;resizecall.ks
; 端末の横幅と縦幅、どちらが大きいかを取得

[iscript]
tf.larger_width = $.getLargeScreenWidth();
[endscript]

[iscript]
;tf.chara_name_str = $(".chara_name_area").text();
[endscript]

;===============================================================================
; 縦持ちの場合

[if exp="tf.larger_width==false"]

; 縦持ちの場合
;[body scWidth=720 scHeight=1280]
[body scWidth=1080 scHeight=1920]

; 名前表示欄
[free layer="message0" name="chara_name_area"]
;[ptext name="chara_name_area" text="&tf.chara_name_str" layer="message0" color="white" size=38 bold=true x=100 y=880]
[ptext name="chara_name_area" layer="message0" color="white" size=57 x=150 y=1320]

; メッセージウィンドウの設定
;[position layer="message0" left=60 top=840 width=580 height=400 page=fore visible=true opacity=222 border_size=3 border_color="white" radius=15 ]
[position layer="message0" left=0 top=1260 width=1080 height=600 page=fore visible=true]

; 文字が表示される領域を調整
;[position layer=message0 page=fore margint="85" marginl="50" marginr="70" marginb="60"]
[position layer=message0 page=fore margint="75" marginl="75" marginr="75" marginb="75"]

[iscript]

f.akane_left = 10;
f.akane_top = 250;
f.akane_width = 700;

f.select_common_x = 60;
f.select_common_width = 500;
f.select_y_array = [250,350,450,550];

f.font_size = 69;

sf.bgImg = "title_1080x1920.jpg";// タイトル画像
sf.bgArr = ["L1_1080x1920.jpg", "L2_1080x1920.jpg", "L3_1080x1920.jpg", "L4_1080x1920.jpg"];// シナリオ画像
sf.className = "Mobile"// 縦長表示
sf.topImg    = "icon-top-210x100.svg";//    上ボタン
sf.bottomImg = "icon-bottom-210x100.svg";// 下ボタン
sf.leftImg   = "icon-left-70x460.svg";//    左ボタン
sf.rightImg  = "icon-right-70x460.svg";//   右ボタン

[endscript]

; このゲームで登場するキャラクターを宣言
;normal：ノーマル
;pain：苦痛
;refuse：拒絶
;shy：恥ずかしい
;angry：怒り
;happy：幸せ
;sad：悲しみ
;nude_：裸

[else]

;===============================================================================
; 横持ちの場合
;[body scWidth=1280 scHeight=720]
[body scWidth=1920 scHeight=1080]

; 名前表示欄
[free layer="message0" name="chara_name_area"]
;[ptext name="chara_name_area" text="&tf.chara_name_str" layer="message0" color="white" size=28 bold=true x=180 y=510]
[ptext name="chara_name_area" layer="message0" color="white" size=40 x=85 y=725]

; メッセージウィンドウの設定
;[position layer="message0" left=160 top=500 width=1000 height=200 page=fore visible=true opacity=222 border_size=3 border_color="white" radius=15]
[position layer="message0" left=35 top=695 width=1850 height=350 page=fore visible=true]

; 文字が表示される領域を調整
;[position layer=message0 page=fore margint="45" marginl="50" marginr="70" marginb="60"]
[position layer=message0 page=fore margint="55" marginl="85" marginr="120" marginb="100"]

[iscript]

f.akane_left = 450;
f.akane_top = 150;
f.akane_width = 400;

f.select_common_x = 360;
f.select_common_width = 500;
f.select_y_array = [150,250,350,450];

f.font_size = 64;

sf.bgImg = "title_1920x1080.jpg";// タイトル画像
sf.bgArr = ["L1_1920x1080.jpg", "L2_1920x1080.jpg", "L3_1920x1080.jpg", "L4_1920x1080.jpg"];// シナリオ画像
sf.className = "Desktop"// 横長表示
sf.topImg    = "icon-top-460x70.svg";//    上ボタン
sf.bottomImg = "icon-bottom-460x70.svg";// 下ボタン
sf.leftImg   = "icon-left-100x210.svg";//  左ボタン
sf.rightImg  = "icon-right-100x210.svg";// 右ボタン

[endscript]

; このゲームで登場するキャラクターを宣言
;normal：ノーマル
;pain：苦痛
;refuse：拒絶
;shy：恥ずかしい
;angry：怒り
;happy：幸せ
;sad：悲しみ
;nude_：裸

[endif]

;===============================================================================
; 共通エリア

; キャラクターが表示されている場合
[chara_move name="akane" left="&f.akane_left" top="&f.akane_top" width="&f.akane_width" time=0  ]

; 選択肢が表示されている場合
[anim name="select_button" left="&f.select_common_x" width="&f.select_common_width" time=0 ]

[anim name="select_button_1" top="&f.select_y_array[0]" time=0 ]
[anim name="select_button_2" top="&f.select_y_array[1]" time=0 ]
[anim name="select_button_3" top="&f.select_y_array[2]" time=0 ]
[anim name="select_button_4" top="&f.select_y_array[3]" time=0 ]

[chara_move name="akane" left="&f.akane_left" top="&f.akane_top" width="&f.akane_width" time=10 ]

[iscript]

$(".message_inner").find("span").css("font-size",f.font_size+"px");

sf.repeatImg  = "icon-repeat-108x108.svg";//  リピートボタン
sf.closeImg   = "icon-close-108x108.svg";//   クローズボタン
sf.messageImg = "icon-message-108x108.svg";// メッセージボタン

[endscript]

[deffont size="&f.font_size"]
[resetfont]

;[wait time=500]

; callで呼ばれるので必ずreturn が必要
[return ]
