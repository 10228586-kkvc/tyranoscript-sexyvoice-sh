@title name="ティラノスクリプト・セクシーボイス-SH"

;-------------------------------------------------------------------------------
*main
*title
[eval exp="f.backLabel = {storage: 'title.ks',target: '*title',next: false}"]



; スタートボタン
[html]
<div id="StartButton">START</div>
[endhtml]

[iscript]
$(".layer_free>div").click(function(){
	event.stopPropagation();// 親イベントを無効化
	// jumpだとなぜかエラーになるのでキーイベントを発生させる
	$("html").trigger({type: 'keydown', keyCode: 40});
});
[endscript]

; タイトル画像
;[call storage="resizecall.ks"]
;[wait time=500]
[iscript]
TYRANO.kag.ftag.startTag("stopbgm",{target:"se", buf:"1", stop: "true"});
TYRANO.kag.ftag.startTag("stopbgm",{target:"se", buf:"3", stop: "true"});

;$('html').off("keydown", sf.changeVoiceKey);
$('html').off("keydown");
$('html').on("keydown", sf.normalKey);
;sf.stop_bgmovie({skip:true, time:0});
;sf.bgmovie({storage:"title.webm", loop:"true", time:0, volume:f.vol});
;TYRANO.kag.ftag.startTag("bg", {storage:sf.bgImg, stop:"true", time:"0"});
[endscript]
[bg storage="&sf.bgImg" time=0]

; メッセージボックスは非表示
@layopt layer=message0 visible=false
;@layopt layer=1 name=title_start visible=true

; 最初は右下のメニューボタンを非表示にする
[hidemenubutton]


.[p]

; 一番最初のシナリオファイルへジャンプする
@jump storage="scene.ks"