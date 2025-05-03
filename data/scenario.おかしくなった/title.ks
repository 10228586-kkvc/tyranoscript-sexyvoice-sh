@title name="ティラノスクリプト-SH"

;-------------------------------------------------------------------------------
*title
[eval exp="f.backLabel = {storage: 'title.ks',target: '*title',next: false}"]

; タイトル画像
[bg storage="&sf.bgImg" time=0]

[iscript]
//$('html').off("keydown", sf.changeVoiceKey);
$('html').off("keydown");
$('html').on("keydown", sf.normalKey);

//sf.stop_bgmovie({skip:true, time:0});
//sf.bgmovie({storage:"title.webm", loop:"true", time:0, volume:f.vol});
//TYRANO.kag.ftag.startTag("bg", {storage:sf.bgImg, stop:"true", time:"0"});
[endscript]

// メッセージボックスは非表示
@layopt layer=message0 visible=false

// 最初は右下のメニューボタンを非表示にする
[hidemenubutton]

// スタートボタン
[html]
<div id="StartButton">START</div>
[endhtml]

[iscript]
$(".layer_free>div").click(function(){
	;TYRANO.kag.ftag.startTag("jump", {storage:"scene.ks", target:"*start"});
	TYRANO.kag.ftag.nextOrder();// next実行
});
[endscript]

.[p]

// 一番最初のシナリオファイルへジャンプする
//@jump storage="scene.ks"
[jump storage="scene.ks" target="*start"]