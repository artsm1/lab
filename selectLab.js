"use strict";

document.observe("dom:loaded", function() {
	/* Make necessary elements Dragabble / Droppables (Hint: use $$ function to get all images).
	 * All Droppables should call 'labSelect' function on 'onDrop' event. (Hint: set revert option appropriately!)
	 * 필요한 모든 element들을 Dragabble 혹은 Droppables로 만드시오 (힌트 $$ 함수를 사용하여 모든 image들을 찾으시오).
	 * 모든 Droppables는 'onDrop' 이벤트 발생시 'labSelect' function을 부르도록 작성 하시오. (힌트: revert옵션을 적절히 지정하시오!)
	 */
	 var selection = $$("#labs>img");
	 for(var i = 0; i< selection.length; i++){
	 	new Draggable(selection[i],{revert: true});
	 }
	 Droppables.add("selectpad", {onDrop: labSelect});
	 var selected_selection = $$("#selectpad>img");
	 for(var i = 0; i< selected_selection.length; i++){
	 	new Draggable(selected_selection[i],{revert: true});
	 }
	 Droppables.add("labs", {onDrop: labSelect});
	});

function labSelect(drag, drop, event) {
	/* Complete this event-handler function 
	 * 이 event-handler function을 작성하시오.
	 */
	 var number = $$("#selection>li").length;
	 if(drop.id != drag.parentNode.id){
	 	if(drop.id == "selectpad"){
	 		if(number<3){
	 			$("labs").removeChild(drag);
	 			$("selectpad").appendChild(drag);
	 			var li = document.createElement("li");
	 			li.innerHTML = drag.getAttribute("alt");
	 			$("selection").appendChild(li);
	 			li.pulsate({
	 				duration: 1.0,
	 				delay: 0.5
	 			});
	 		}
	 	}
	 	else if(drop.id == "labs"){
	 		$("selectpad").removeChild(drag);
	 		$("labs").appendChild(drag);
	 		var draged_li;
	 		for(var i = 0; i< $$("#selection>li").length ; i++){
	 			if(drag.getAttribute("alt") == $$("#selection>li")[i].innerHTML){
	 				draged_li = $$("#selection>li")[i];
	 			}
	 		}
	 		$("selection").removeChild(draged_li);
	 	}
	 }
	}
