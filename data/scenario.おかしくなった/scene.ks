*start
[iscript]
f.curArr = [];
for(let i=0; i<4; i++){f.curArr[i] = sf.arrayShuffle(sf.hteArr[i].length);}
f.hlv = 0;
f.plv = 1;
$('html').off("keydown", sf.changeVoiceKey);
TYRANO.kag.ftag.startTag("stopbgm",{target:"se", stop: "true"});

[endscript]
[call storage="resizecall.ks"]
;-------------------------------------------------------------------------------
*main
[eval exp="f.backLabel = {storage: 'title.ks',target: '*title',next: false}"]
@layopt layer=message0 visible=true
[cm]

[iscript]
TYRANO.kag.ftag.startTag("stopbgm",{target:"se", buf:"1", stop: "true"});
if(f.hlv!=f.plv){
	TYRANO.kag.ftag.startTag("playbgm", {storage:sf.lseArr[f.hlv], target:"se", loop:"true", buf:"3", stop:"true"});
	TYRANO.kag.ftag.startTag("bg", {storage:sf.bgArr[f.hlv], stop:"true", time:"0"});
/*
	tf.aegis[f.plv] = null;
	tf.aegis[f.hlv]=new Audio();
	tf.aegis[f.hlv].src = "./data/sound/" + sf.lvoArr[f.hlv];

	tf.aegis[f.hlv].load();
*/
	f.plv=f.hlv;
}
;sf.stop_bgmovie({skip:true, time:0});
$('html').off("keydown", sf.changeVoiceKey);
$('html').on("keydown", sf.changeVoiceKey);
[endscript]

[iscript]

TYRANO.kag.ftag.startTag("emb",{"exp":"sf.hteArr[f.hlv][f.curArr[f.hlv][f.hvo]]"});
TYRANO.kag.ftag.startTag("playse", {storage:sf.hvoArr[f.hlv][f.curArr[f.hlv][f.hvo]], loop:"false", buf:"1"});
f.pse = TYRANO.kag.tmp.map_se[1]._src;


let timerId = setInterval(function(){

	f.lvoStart = sf.getRandomInt(0, (tf.aegis[f.hlv].duration*1000)-sf.lvoLen);
	if(f.pse!=TYRANO.kag.tmp.map_se[1]._src) {
		console.log("SE変更");
		//TYRANO.kag.ftag.startTag("stopbgm",{target:"se", buf:"1", stop: "true"});

		clearInterval(timerId);
	} else if(TYRANO.kag.tmp.map_se[1]._sounds[0]._ended){ 
		console.log("SE終了");
		console.log(tf.aegis[f.hlv].src);

		//f.lvoStart = sf.getRandomInt(0, (tf.aegis[f.hlv].duration*1000)-sf.lvoLen);
		//console.log(f.lvoStart);

		TYRANO.kag.ftag.startTag("playbgm", {storage:tf.aegis[f.hlv].src, sprite_time:f.lvoStart+"-"+(f.lvoStart+sf.lvoLen), target:"se", buf:"1", stop:"true"});

		clearInterval(timerId);
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
