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

;-------------------------------------------------------------------------------
; 開始
*main
[eval exp="f.backLabel = {storage: 'title.ks',target: '*title',next: false}"]
@layopt layer=message0 visible=true
[cm]

[iscript]
TYRANO.kag.ftag.startTag("stopbgm",{target:"se", buf:"1", stop: "true"});

; シーンが切り替わっていたら喘ぎ声とSEを変更する
if(f.hlv!=f.plv){
	TYRANO.kag.ftag.startTag("playbgm", {storage:sf.lseArr[f.hlv], target:"se", loop:"true", buf:"3", stop:"true"});
	TYRANO.kag.ftag.startTag("bg", {storage:sf.bgArr[f.hlv], stop:"true", time:"0"});
	f.plv=f.hlv;
	console.log("初回");
}
$('html').off("keydown", sf.changeVoiceKey);// キーイベントオフ
$('html').on("keydown", sf.changeVoiceKey);// キーイベントオン

[endscript]
; ここで[endscript]と[iscript]を入れないとなぜかシーンが止まらなくなる
[wait time=2000]
[iscript]

TYRANO.kag.ftag.startTag("emb",{"exp":"sf.hteArr[f.hlv][f.curArr[f.hlv][f.hvo]]"});// 音声セリフ表示
TYRANO.kag.ftag.startTag("playse", {storage:sf.hvoArr[f.hlv][f.curArr[f.hlv][f.hvo]], loop:"false", buf:"1"});// SE再生
if (TYRANO.kag.tmp.map_se[1] && typeof TYRANO.kag.tmp.map_se[1]._src !== "undefined") f.pse = TYRANO.kag.tmp.map_se[1]._src;// 前回再生したSEのID保存
else {

}

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
