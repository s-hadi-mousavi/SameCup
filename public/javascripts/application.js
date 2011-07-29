$(function() {
	
	// $(".sticker").rightClick(function(e) {
	//    	console.log(e);
	// });
	


	$('#sprint_start_at').datepicker({ dateFormat: 'yy-mm-dd'});
	$('#sprint_end_at').datepicker({ dateFormat: 'yy-mm-dd'});

			
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

