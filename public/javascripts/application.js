$(function() {
	
	// $(".sticker").rightClick(function(e) {
	//    	console.log(e);
	// });
	
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
	

	$('#sprint_start_at').datepicker({ dateFormat: 'yy-mm-dd'});
	$('#sprint_end_at').datepicker({ dateFormat: 'yy-mm-dd'});

			
});

// Feedback and loading functions
function showLoading()
{
  if(window.loadingDlg)
    window.loadingDlg.dialog('open');
}
function hideLoading()
{
  if(window.loadingDlg)
    window.loadingDlg.dialog('close');
}
function enableFeedback()
{
  $('#feedback_content > input').removeAttr("disabled");
  $('#feedback_content > textarea').removeAttr("disabled");
  $('#feedback_progress').hide();
  $('#feedback_buttons').show();
  
}
function disableFeedback()
{
  $('#feedback_progress').show();
  $('#feedback_buttons').hide();
  $('#feedback_content > input').attr("disabled","true");
  $('#feedback_content > textarea').attr("disabled","true");

}
function showFeedback()
{
  if(window.feedbackDlg)
  {
    enableFeedback();
    $('#feedback_content').show();
    $('#feedback_thankyou').hide();
    window.feedbackDlg.dialog('open');
  }
}
function hideFeedback()
{
  if(window.feedbackDlg)
    window.feedbackDlg.dialog('close');
}

function showUpgrade(projectName, projectId)
{
  if(window.upgradeDlg)
  {
    $('#upgrade_project_id').val(projectId);
    $('#upgrade_project_title').html(projectName);
    window.upgradeDlg.dialog('open');
  }
}
function hideUpgrade()
{
  if(window.upgradeDlg)
    window.upgradeDlg.dialog('close');
}

