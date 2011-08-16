$(function() {
	
	// $(".sticker").rightClick(function(e) {
	//    	console.log(e);
	// });
	


	$('#sprint_start_at').datepicker({ dateFormat: 'yy-mm-dd'});
	$('#sprint_end_at').datepicker({ dateFormat: 'yy-mm-dd'});
  
  if((flash = $('#jflash')).html().trim() != "") $.alertMe(flash.html());
			
});

(function($) {
    var uid = 0;
    $.getUID = function() {
        uid++;
        return 'jQ-uid-'+uid;
    };
    $.fn.getUID = function() {
        if(!this.length) {
            return 0;
        }
        var fst = this.first(), id = fst.attr('id');
        if(!id) {
            id = $.getUID();
            fst.attr('id', id);
        }
        return id;
    }
})(jQuery);

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
  
  
  function notify(flash_message) 
  { 
      // jQuery: reference div, load in message, and fade in 
        var flash_div = $("#jflash") 
        flash_div.html(flash_message); 
        flash_div.fadeIn(400); 
      // use Javascript timeout function to delay calling 
      // our jQuery fadeOut, and hide 
      setTimeout(function(){ 
                  flash_div.fadeOut(500, function(){ flash_div.html(""); flash_div.hide()})}, 
                  1400); 
  } 

