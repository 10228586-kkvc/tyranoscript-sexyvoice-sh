//------------------------------------------------------------------------------
// スワイプ
/*
$(function () {
	$("html").on("touchstart", start_check);
	$("html").on("touchmove", move_check);
});

function start_check(e){
	// 現在の座標取得
	posiY = getY(e);
	posiX = getX(e);

	// 移動距離状態を初期化
	moveY = '';
	moveX = '';
}

function move_check(e){
	if (posiX - getX(e) > 70){$("html").trigger({type: 'keydown', keyCode: 39});}// 右→左:Key[→]
	else if (posiX - getX(e) < -70){$("html").trigger({type: 'keydown', keyCode: 37});}// 左→右:Key[←]

	if (posiY - getY(e) > 70){$("html").trigger({type: 'keydown', keyCode: 40});}// 下→上:Key[↓]
	else if (posiY - getY(e) < -70){$("html").trigger({type: 'keydown', keyCode: 38})}// 上→下:Key[↑]

}
// 座標取得処理
function getY(e){return (e.originalEvent.touches[0].pageY);}// 縦方向の座標を取得
function getX(e){return (e.originalEvent.touches[0].pageX);}// 横方向の座標を取得
*/

//------------------------------------------------------------------------------
// ゲームパッド v1.1(2025.04.29)
// iOS Safariはページロード時に接続済みのゲームパッドを検知しない仕様になっている。
var axh = 0;
var axv = 0;
var bt = [];
var running = false; // 無限ループ実行中かどうか
var loopId;          // requestAnimationFrameのIDを保存

function loop() {

	if (!running) return; // runningがfalseなら抜ける

	let gamepads = navigator.getGamepads? navigator.getGamepads(): [];
	//console.log(`ゲームパッド接続数：${gamepads.length}`);
	if(gamepads.length){
	
		gp = gamepads[0];

		// ボタン検知
		if(gp.buttons[0].pressed) {if(bt[0]==0) {bt[0]=1;$("html").trigger({type: 'keydown', keyCode: 13});console.log("A");}} else bt[0]=0;// Aボタン:Key[ENTER]
		if(gp.buttons[1].pressed) {if(bt[1]==0) {bt[1]=1;$("html").trigger({type: 'keydown', keyCode:  8});console.log("B");}} else bt[1]=0;// Bボタン:Key[BACKSPACE]
		if(gp.buttons[2].pressed) {if(bt[2]==0) {bt[2]=1;$("html").trigger({type: 'keydown', keyCode: 17});console.log("X");}} else bt[2]=0;// Xボタン:Key[CTR]
		if(gp.buttons[3].pressed) {if(bt[3]==0) {bt[3]=1;$("html").trigger({type: 'keydown', keyCode: 32});console.log("Y");}} else bt[3]=0;// Yボタン:Key[SPACE]
		if(gp.buttons[4].pressed) {console.log("4");}//  LBボタン
		if(gp.buttons[5].pressed) {console.log("5");}//  RBボタン
		if(gp.buttons[6].pressed) {console.log("6");}//  LTボタン
		if(gp.buttons[7].pressed) {console.log("7");}//  RTボタン
		if(gp.buttons[8].pressed) {console.log("8");}//  BACKボタン
		if(gp.buttons[9].pressed) {console.log("9");}//  STARTボタン
		if(gp.buttons[10].pressed) {console.log("10")}// L3ボタン
		if(gp.buttons[11].pressed) {console.log("11")}// R3ボタン
		if(gp.buttons[12].pressed) {if(bt[12]==0) {bt[12]=1;$("html").trigger({type: 'keydown', keyCode: 38});console.log("UP");}} else bt[12]=0;// UPボタン
		if(gp.buttons[13].pressed) {if(bt[13]==0) {bt[13]=1;$("html").trigger({type: 'keydown', keyCode: 40});console.log("DOWN");}} else bt[13]=0;// DOWNボタン
		if(gp.buttons[14].pressed) {if(bt[14]==0) {bt[14]=1;$("html").trigger({type: 'keydown', keyCode: 37});console.log("LEFT");}} else bt[14]=0;// LEFTボタン
		if(gp.buttons[15].pressed) {if(bt[15]==0) {bt[15]=1;$("html").trigger({type: 'keydown', keyCode: 39});console.log("RIGHT");}} else bt[15]=0;// RIGHTボタン

		//if(gp.buttons[16].pressed) {}// HOMEボタン

		// 十字キー検知
		if(gp.axes[0]==-1) {// 十字キー左
			if(axh==0){ 
				axh += gp.axes[0];
				$("html").trigger({type: 'keydown', keyCode: 37});// Key[←]
				console.log("Key[←]");
			}
		} else if(gp.axes[0]==1) {// 十字キー右
			if(axh==0){ 
				axh += gp.axes[0];
				$("html").trigger({type: 'keydown', keyCode: 39});// Key[→]
				console.log("Key[→]");
			}
		} else {axh = 0;}

		if(gp.axes[1]==-1) {// 十字キー上
			if(axv==0){ 
				axv += gp.axes[1];
				$("html").trigger({type: 'keydown', keyCode: 38});// Key[↑]
				console.log("Key[↑]");
			}
		} else if(gp.axes[1]==1) {// 十字キー下
			if(axv==0){ 
				axv += gp.axes[1];
				$("html").trigger({type: 'keydown', keyCode: 40});// Key[↓]
				console.log("Key[↓]");
			}
		} else {axv = 0;}
	}


	loopId = requestAnimationFrame(loop);
}

// ゲームパッド接続時
window.addEventListener("gamepadconnected", (event) => {
	console.log(`ゲームパッド接続`);
	if (!running) { // すでに動いてたら二重に開始しない
		running = true;
		loop();
	}
});


window.addEventListener("gamepaddisconnected", (event) => {
	console.log(`ゲームパッド切断`);
	running = false;
	if (loopId) {
		cancelAnimationFrame(loopId); // 必要なら現在のrequestAnimationFrameもキャンセル
		loopId = null;
	}
});

if(!window.ongamepadconnected) (event) => {
	console.log(`Chromeはイベントが起きないので直接loop実行`);
	if (!running) { // すでに動いてたら二重に開始しない
		running = true;
		loop();
	}
}
