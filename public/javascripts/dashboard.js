Dashboard = {
  backlogContainer: 0,
  
  init: function()
  {
    window.userStoryDlg = $('#user_story_dialog').dialog({ width: 400, height: 400, 
        closeOnEscape:true, draggable:false, modal: true, resizable: true, zIndex: 9999999999, 
       autoOpen:false});
       
    
    $('.state').sortable({
      connectWith: '.state',
      
    })
    .disableSelection()
    .droppable({
      hoverClass: 'active',
      drop: Dashboard.stickerDrop
    });
    
    Dashboard.backlogContainer = $('.backlog');
    
    $("#backlog").droppable({
      hoverClass: 'activelog',
      drop: Dashboard.stickerDrop
    });
        
  
    
    //make live event for stickers
    $('.sticker')
    .live('dblclick',Dashboard.stickerDblClick);
    
    $(".new-sticker").draggable({
      cursor: 'move',
      connectWith: '.state',
      cursorAt: { top: 0, left: 0 },
      helper: function(event) {
        return $('#newsticker>.sticker').clone();
      }
    });

  },
  stickerDrop: function(event, ui) {
    var el = $(ui.helper);
    var container = $(this);
    var state_id = container.attr('state_id');
    var user_id = container.attr('user_id');

    if(el.hasClass('new') == true) {//create new sticker
      var id = $.getUID();
      var _el = $('#newsticker>.sticker').clone();
      var url = _el.attr('url');
      _el.attr('id', id)
      .removeClass('new');
      container.append(_el);
      
      if(url.length > 0){
        $.ajax({
          url: url,
          data: { 'sticker_id': id, 'state_id': state_id, 'user_id': user_id},
          dataType: 'script',
          type: 'POST'
        })
      }      
    }else{//if not new
        var url = el.attr('sticker_url');
        $.ajax({
          url: url,
          data: { 'sticker[state_id]': state_id, 'sticker[user_id]': user_id},
          dataType: 'script',
          type: 'PUT'
        })
        
    }
    
  },

  stickerDblClick: function(e){
    var sticker = $(this);
    var url = sticker.attr('sticker_url');

    var form_url = sticker.attr('form_url');
    var state_id = sticker.parent().attr('state_id');

    $.ajax({
      url: form_url,
      data: {  },
      dataType: 'script',
      type: 'GET'
    })
  },

  stickerFormBlur: function(e){
    var el = $(this);
    var form = el.parent();
    form.submit();
  },
  stickerFormKeyPress: function(e){
     if (e.keyCode == '13' && e.shiftKey == true) {
           e.preventDefault();
           $(this).parent().submit();
     }
  },
  toggleBacklog: function(e){
    Dashboard.backlogContainer.toggle();
  }
  
}
function toggleBlock(id)
{
  $('#task'+id).toggleClass('minimized');
  $('#task'+id+'>.short_desc').toggle();
  $('#task'+id+'>.long_desc').toggle(); 
}

$(function(){
Dashboard.init();
});
  /*
  
  // $('.description-<%= @sticker.id -%>').keypress(function(event) {
  //   if (event.keyCode == '13' && event.shiftKey == true) {
  //      event.preventDefault();
  //      $('#edit_sticker_<%= @sticker.id -%>').submit();
  //    }
  // });
  // 
  // $('.description-<%= @sticker.id -%>').blur(function(event){
  //   $('#edit_sticker_<%= @sticker.id -%>').submit();
  // })
  
  
  	$(".sticker").draggable({
  				cursor: 'move',
  				revert: true
  	});


  	$(".new-sticker").draggable({
  				cursor: 'move',
  				cursorAt: { top: 0, left: 0 },
  				helper: function(event) {
  					return $('<div class="sticker new" style="position:absolute;opacity:0.95;z-index:99999999990 !important;">As a user I want</div>');
  				}
  	});
  	$("#backlog").droppable({
    				hoverClass: 'activelog',
    				drop: function(event, ui) {
    				  project_id = $('.project').attr('project-id');
  						sprint_id = $('.project').attr('sprint-id');
    					sticker_obj =  $(ui.draggable);
    					sticker_id = sticker_obj.attr('sticker-id');


    					if($(ui.helper).hasClass('new') == true) {
    						obj = $(this).children('div.relative');
    						parentPosition = $(this).position();
    						stickerPosition = ui.offset;

    						_left = (stickerPosition.left - parentPosition.left);
    						_top = (stickerPosition.top - parentPosition.top)

    						$.ajax({
    								 url: '/projects/'+project_id+'/sprints/'+sprint_id+'/stickers',
    								 data: {	
    													'sticker[user_id]':0,
    													'sticker[state_id]':0,
    													'sticker[left]': _left,
    													'sticker[top]': _top,
    													'sticker[description]': 'As a user I want '},
    								 dataType: 'script',
    								 type: 'POST',
    								success: function(data) {obj.append(data);}
    				            });
    					} else {
    					  sticker_obj.parent().remove('.sticker[sticker-id='+sticker_id+']');
      					$(this).children(".relative").append(sticker_obj);

    						$(ui.helper).draggable( "option", "revert", false);
    						parentPosition = $(this).position();
    						stickerPosition = ui.offset;

    						_left = (stickerPosition.left - parentPosition.left)-3;
    						_top = (stickerPosition.top - parentPosition.top)-24;

    						// console.log(stickerPosition.left - parentPosition.left)
    						// console.log(stickerPosition.top - parentPosition.top)

    						sticker_id = $(ui.draggable).attr('sticker-id');



    //console.log( _left + ":" + _top + "  "+state_id);
    						$.ajax({
    						            url:'/projects/'+project_id+'/sprints/'+sprint_id+'/stickers/'+sticker_id+'/sort',
    				                data: {
    				                'sticker[state_id]':0,
    				                'sticker[user_id]':0,
    									   'sticker[left]': _left,
    									   'sticker[top]': _top
    									},
    				                dataType: 'script',
    				                type: 'PUT'
    			            });
            					//change position
            					sticker_obj.css('left', _left);
            					sticker_obj.css('top', _top);

    					}

    				}
    	});
  	$("table.project td.column").droppable({
  				hoverClass: 'active',
  				drop: function(event, ui) {
  				  project_id = $('.project').attr('project-id');
  					sprint_id = $('.project').attr('sprint-id');
  					sticker_obj =  $(ui.draggable);
  					sticker_id = sticker_obj.attr('sticker-id');


  					if($(ui.helper).hasClass('new') == true) {

  						user_id = $(this).parent('tr').attr('user-id');
  						state_id = $(this).attr('state-id');
  						obj = $(this).children('div.relative');
  						parentPosition = $(this).position();
  						stickerPosition = ui.offset;

  						_left = (stickerPosition.left - parentPosition.left);
  						_top = (stickerPosition.top - parentPosition.top)

  						$.ajax({
  								 url: '/projects/'+project_id+'/sprints/'+sprint_id+'/stickers',
  								 data: {	'sticker[user_id]': user_id, 
  													'sticker[state_id]': state_id,
  													'sticker[left]': _left,
  													'sticker[top]': _top,
  													'stickers[sprint_id]': sprint_id,
  													'sticker[description]': 'As a user I want '},
  								 dataType: 'script',
  								 type: 'POST',
  								success: function(data) {obj.append(data);}
  				            });
  					} else {
  					  sticker_obj.parent().remove('.sticker[sticker-id='+sticker_id+']');
    					$(this).children(".relative").append(sticker_obj);

  						$(ui.helper).draggable( "option", "revert", false);
  						parentPosition = $(this).position();
  						stickerPosition = ui.offset;

  						_left = (stickerPosition.left - parentPosition.left)-5;
  						_top = (stickerPosition.top - parentPosition.top)-5;

  						sticker_id = $(ui.draggable).attr('sticker-id');
  						user_id = $(this).parent('tr').attr('user-id');
  						state_id = $(this).attr('state-id');

  //console.log( _left + ":" + _top + "  "+state_id);
  						$.ajax({
  				                url:'/projects/'+project_id+'/sprints/'+sprint_id+'/stickers/'+sticker_id+'/sort',
  				                data: {
  				             'sticker[user_id]': user_id, 
  									   'sticker[state_id]': state_id,
  									   'sticker[left]': _left,
  									   'sticker[top]': _top
  									},
  				                dataType: 'script',
  				                type: 'PUT'
  			            });
  					}
  					//change position
  					sticker_obj.css('left', _left);
  					sticker_obj.css('top', _top);
  				}
  	});
  */