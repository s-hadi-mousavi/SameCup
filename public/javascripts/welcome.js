Welcome = {
  embed:0,
  init: function(){
    $('.video').click(Welcome.showVideo);
    Welcome.embed = $('#videoembed').dialog({autoOpen:false,modal: true, 
      width:680, height:440, draggable: false, resizable: false});

  },
  showVideo: function(e){
    Welcome.embed.dialog('open');
    e.preventDefault();
  }
  
}

$(Welcome.init);