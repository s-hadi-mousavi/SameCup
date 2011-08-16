$.alertMe = function(text,button) {

 	var body = $("body");
	var box = $("#alertBox");
	var cover = $("#cover");
	var boxWidth = 300;
	if(!button) button = 'OK';
	
  //defention
  
 	$("<div id=\"alertMe_cover\"></div>").prependTo(body);
	$("<div id=\"alertBox\"><div class=\"alertBoxtext\"><p>"+ text +"</p></div><div class=\"alertBoxbutton\"><a href=\"javascript:void(0);\" id=\"closeAlert\">"+button+"</div></div></div>").prependTo(body);
	
	
	$("#alertMe_cover").css({
		'background-color':'#999',
		'position':'fixed',
		'z-index':'999',
		'-ms-filter': "progid:DXImageTransform.Microsoft.Alpha(Opacity=40)",
  	/* IE 5-7 */
	 ' filter': 'alpha(opacity=40)',
 	/* Netscape */
	 '-moz-opacity': 0.4,
 	/* Safari 1.x */
	 '-khtml-opacity': 0.4,
	 /* Good browsers */
	 'opacity': 0.4,
	});
	
	$("#alertBox").css({
		'width': boxWidth,
		'background-color':'#fff',
		'position':'fixed',
		'z-index':'1001',
		'-moz-border-radius': 4,
	  	'-webkit-border-radius': 4,
	    ' border-radius': 4,
		'border':'1px solid #45454',
		'-moz-box-shadow': '1px 2px 6px #999' ,
		'-webkit-box-shadow': '1px 2px 6px #999', 
		'box-shadow': '1px 2px 6px #999'
		});
 	$(".alertBoxtext").css({
		'width':280,
		'padding':10,	
		'border-bottom': '1px solid #ccc',
		});
	$(".alertBoxtext p").css({
		'padding-top':5,
		'padding-bottom':5,
		'padding-left':5,
		'font-family': 'Helvetica, Arial, sans-serif',
		'font-size': 14,
		'font-style':' normal',
		'font-weight': 'normal',
		'text-transform': 'normal',
		'letter-spacing': 'normal',
		'line-height': '1.4em'
		});
	$(".alertBoxbutton").css({
		'background-color': '#ccc',
		'border-top': '1px solid #efefef',
		'padding-bottom': 5,
	    'padding-top': 5,
	    'width': 300,
		'float':'left',
		
		});
	$("#closeAlert").css({
		'padding': '10px',
		'background-color': '#EFEFEF',
	    'border':' 1px solid #CCCCCC',
	    'float': 'right',
	    'padding': '3px 10px',
	    'position': 'relative',
		'margin-right':10,
		'-moz-border-radius': 4,
	  	'-webkit-border-radius': 4,
	    ' border-radius': 4,
		'border':'1px solid #45454',
		'color':'#454545',
		'text-decoration':'none',
		'outline':'none',
		'font-family': 'Helvetica, Arial, sans-serif',
		'font-size': 12,
		'font-style':' normal',
		'font-weight': 'normal',
		'text-transform': 'normal',
		'letter-spacing': 'normal',
		'line-height': '1.4em',	
		});
	
	
  	//events
  	function adjustToWindow(){
    	 var w = $(window); 
    	 $('#alertMe_cover').css({'width':w.width(), 'height':w.height()});
    	 $("#alertBox").css("top", ((w.height() - $("#alertBox").outerHeight()) / 2) + w.scrollTop() + "px");
       $("#alertBox").css("left", ((w.width() - $("#alertBox").outerWidth()) / 2) + w.scrollLeft() + "px");
  	}
  	function onClose(){
  		$("#alertMe_cover,#alertBox").fadeOut(200, function(){$(this).remove();});
  	}

  	//onresize
    $(window).resize(adjustToWindow);
    
    //resize right now
    adjustToWindow();
	
    //close on clicking close or on cover
    $('#alertMe_cover').click(onClose);
	  $("#closeAlert").click(onClose);

}

