"use strict";

var numberOfBlocks = 9;
var targetBlocks = [];
var trapBlock;
var targetTimer;
var trapTimer;
var instantTimer;


document.observe('dom:loaded', function(){
	$("start").observe("click", clickToStart);
	$("stop").observe("click", stopGame);
});

function clickToStart(){
	$("state").textContent = "Ready!";
	$("score").textContent = "0";
	instantTimer = setTimeout(startGame, 3000);
}

function startGame(){
	targetBlocks = [];
	clearTimeout(targetTimer);
	clearTimeout(trapTimer);
	clearTimeout(instantTimer);
	startToCatch();
}

function stopGame(){
	$("state").textContent = "Stop";
	targetBlocks = [];
	clearTimeout(targetTimer);
	clearTimeout(trapTimer);
	clearTimeout(instantTimer);
	$("score").textContent = "0";
	var blocks = $$(".block");
	for (var i = 0; i < numberOfBlocks; i++) {
		blocks[i].removeClassName("target");
		blocks[i].removeClassName("wrong");
		blocks[i].removeClassName("trap");
		blocks[i].removeClassName("normal");
		blocks[i].addClassName("normal");
		blocks[i].stopObserving("click");
	}
}

function setTargetBlock() {
	if (targetBlocks.length > 4) {
		alert("You lose");
		clearInterval(targetTimer);
		clearInterval(trapTimer);
		clearInterval(instantTimer);
	} else {
		var randNum;
		randNum = Math.floor(Math.random() * 9);
		var blocks = $$(".block");
		while(blocks[randNum].hasClassName("target") || trapBlock == randNum) {
			randNum = Math.floor(Math.random() * 9);
		}
		blocks[randNum].removeClassName("normal");
		blocks[randNum].addClassName("target");
		targetBlocks.push(randNum);
	}
}

function setTrapBlock() {
	var randNum;
	randNum = Math.floor(Math.random() * 9);
	var blocks = $$(".block");
	while(blocks[randNum].hasClassName("target")) {
		randNum = Math.floor(Math.random() * 9);
	}
	blocks[randNum].removeClassName("normal");
	blocks[randNum].addClassName("trap");
	trapBlock = randNum;
	setTimeout(function() {blocks[trapBlock].removeClassName("trap");blocks[trapBlock].addClassName("normal");}, 2000);
}

function startToCatch(){
	$("state").textContent = "Catch!";
	targetTimer = setInterval(setTargetBlock, 1000);
	trapTimer = setInterval(setTrapBlock, 3000);
	var blocks = $$(".block");
	for (var i = 0; i < numberOfBlocks; i++) {
		blocks[i].observe("click", score);
	}
}

function score() {
	var selectedBlockNum = this.readAttribute("data-index");
	var blocks = $$(".block");
	var score;
	if (blocks[selectedBlockNum].hasClassName("normal")) {
		score = -10;
		blocks[selectedBlockNum].addClassName("wrong");
		setTimeout(function() {blocks[selectedBlockNum].removeClassName("wrong");}, 100);
		blocks[selectedBlockNum].addClassName("normal");
	} else if (blocks[selectedBlockNum].hasClassName("target")) {
		score = 20;
		blocks[selectedBlockNum].removeClassName("target");
		blocks[selectedBlockNum].addClassName("normal");
		targetBlocks.splice(targetBlocks.indexOf(selectedBlockNum), 1);
	} else if (blocks[selectedBlockNum].hasClassName("trap")) {
		score = -20;
		blocks[selectedBlockNum].removeClassName("trap");
		blocks[selectedBlockNum].addClassName("normal");
	}
	$("score").innerHTML = parseFloat($("score").innerHTML) + score;
}
