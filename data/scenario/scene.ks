;-------------------------------------------------------------------------------
; 初期化
*start
[iscript]
; 音声リストをシャッフルする
f.curArr = [];
for(let i=0; i<4; i++){f.curArr[i] = sf.arrayShuffle(sf.hteArr[i].length);}
f.hlv = 0;
f.plv = 1;
$('html').off("keydown", sf.changeVoiceKey);
TYRANO.kag.ftag.startTag("stopbgm",{target:"se", stop: "true"});

[endscript]



; 画面切り替え処理
;[call storage="resizecall.ks"]
;[set_resizecall storage="resizecall.ks"]



;-------------------------------------------------------------------------------
; 開始
*main
[eval exp="f.backLabel = {storage: 'title.ks',target: '*title',next: false}"]
@layopt layer=message0 visible=true
[cm]


[html]
<div id="TopButton" class="[emb exp='sf.className'] Active"><img src="./data/image/[emb exp='sf.topImg']" alt="上ボタン"></div>
<div id="BottomButton" class="[emb exp='sf.className'] Active"><img src="./data/image/[emb exp='sf.bottomImg']" alt="下ボタン"></div>
<div id="LeftButton" class="[emb exp='sf.className'] Active"><img src="./data/image/[emb exp='sf.leftImg']" alt="左ボタン"></div>
<div id="RightButton" class="[emb exp='sf.className'] Active"><img src="./data/image/[emb exp='sf.rightImg']" alt="右ボタン"></div>
<div id="RepeatButton" class="[emb exp='sf.className'] Active"><img src="./data/image/[emb exp='sf.repeatImg']" alt="リピートボタン"></div>
<div id="CloseButton" class="[emb exp='sf.className'] Active"><img src="./data/image/[emb exp='sf.closeImg']" alt="クローズボタン"></div>
<div id="MassageButton" class="[emb exp='sf.className']"><img src="./data/image/[emb exp='sf.messageImg']" alt="メッセージボタン"></div>
[endhtml]

[iscript]
$(".layer_free>div").click(function(){
	event.stopPropagation();// 親イベントを無効化
	// jumpだとなぜかエラーになるのでキーイベントを発生させる
	$("html").trigger({type: 'keydown', keyCode: 40});
});
$("#TopButton"   ).click(function(){event.stopPropagation();$("html").trigger({type: 'keydown', keyCode: 38});console.log("Key[↑]");});
$("#BottomButton").click(function(){event.stopPropagation();$("html").trigger({type: 'keydown', keyCode: 40});console.log("Key[↓]");});
$("#LeftButton"  ).click(function(){event.stopPropagation();$("html").trigger({type: 'keydown', keyCode: 37});console.log("Key[←]");});
$("#RightButton" ).click(function(){event.stopPropagation();$("html").trigger({type: 'keydown', keyCode: 39});console.log("Key[→]");});

$("#RepeatButton" ).click(function(){event.stopPropagation();$("html").trigger({type: 'keydown', keyCode: 8});console.log("Key[BACKSPACE]");});

$("#CloseButton"  ).click(function(){
	event.stopPropagation();
	$("html").trigger({type: 'keydown', keyCode: 32});
	console.log("Key[SPACE]");
});

$("#MassageButton").click(function(){
	event.stopPropagation();
	$("html").trigger({type: 'keydown', keyCode: 32});
	console.log("Key[SPACE]");
});
[endscript]


[iscript]
TYRANO.kag.ftag.startTag("stopbgm",{target:"se", buf:"1", stop: "true"});

; シーンが切り替わっていたら喘ぎ声とSEを変更する
if(f.hlv!=f.plv){
	TYRANO.kag.ftag.startTag("playbgm", {storage:sf.lseArr[f.hlv], target:"se", loop:"true", buf:"3", stop:"true"});
	TYRANO.kag.ftag.startTag("bg", {storage:sf.bgArr[f.hlv], stop:"true", time:"0"});
	f.plv=f.hlv;
}
$('html').off("keydown", sf.changeVoiceKey);// キーイベントオフ
$('html').on("keydown", sf.changeVoiceKey);// キーイベントオン



[endscript]
; ここで[endscript]と[iscript]を入れないとなぜかシーンが止まらなくなる
[iscript]

TYRANO.kag.ftag.startTag("emb",{"exp":"sf.hteArr[f.hlv][f.curArr[f.hlv][f.hvo]]"});// 音声セリフ表示
TYRANO.kag.ftag.startTag("playse", {storage:sf.hvoArr[f.hlv][f.curArr[f.hlv][f.hvo]], loop:"false", buf:"1"});// SE再生
f.pse = TYRANO.kag.tmp.map_se[1]._src;// 前回再生したSEのID保存

; タイマーループ
let timerId = setInterval(function(){
	if(f.pse!=TYRANO.kag.tmp.map_se[1]._src) {
		console.log("SE変更");
		; 初回再生時に再生されないのでコメントアウト
		;TYRANO.kag.ftag.startTag("stopbgm",{target:"se", buf:"1", stop: "true"});
		clearInterval(timerId);

	} else if(TYRANO.kag.tmp.map_se[1]._sounds[0]._ended){ 
		console.log("SE終了");
		console.log(tf.aegis[f.hlv].src);

		f.lvoStart = sf.getRandomInt(0, (tf.aegis[f.hlv].duration*1000)-sf.lvoLen);// 喘ぎ声開始位置をランダムに計算
		;console.log(f.lvoStart);

		; 喘ぎ声再生
		TYRANO.kag.ftag.startTag("playbgm", {storage:tf.aegis[f.hlv].src, sprite_time:f.lvoStart+"-"+(f.lvoStart+sf.lvoLen), target:"se", buf:"1", stop:"true"});

		clearInterval(timerId);

		; 喘ぎ声再生後次のセリフへ
		let timerId2 = setInterval(function(){clearInterval(timerId2);TYRANO.kag.ftag.startTag("jump",{target:"*prev"});}, sf.lvoLen)
	}
}, 500)

[endscript]

.[p]

[iscript]
f.hvo=0;
if(f.hlv==3){f.hlv=0}else{f.hlv++;}
[endscript]
@jump target=*main
[s]
;-------------------------------------------------------------------------------
; 繰り返し
*repeat
[iscript]
$('html').off("keydown", sf.changeVoiceKey);
[endscript]
@jump target=*main

[s]
;-------------------------------------------------------------------------------
; ＜＜・左
*prev
[iscript]
$('html').off("keydown", sf.changeVoiceKey);
if(f.hvo>0) f.hvo--;
else f.hvo=sf.hteArr[f.hlv].length-1;
[endscript]
@jump target=*main

[s]
;-------------------------------------------------------------------------------
; ＞＞・右
*next
[iscript]
$('html').off("keydown", sf.changeVoiceKey);
if(f.hvo<sf.hteArr[f.hlv].length-1) f.hvo++;
else f.hvo=0;
[endscript]
@jump target=*main

[s]
;-------------------------------------------------------------------------------
