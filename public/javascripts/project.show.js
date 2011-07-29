ProjectShow = {
  init: function(){
    window.userStoryDlg = $('#user_story_dialog').dialog({ width: 400, height: 400, 
        closeOnEscape:true, draggable:false, modal: true, resizable: true, zIndex: 9999999999, 
       autoOpen:false});
       $('#feedback_button').hide();
       
  },
  refreshDashboard: function(){
    showLoading();
     $.ajax({
            url: '%%= refresh_project_path(@project, :sprint_id =} @sprint.id) -%}',
            type: 'GET',
            success: function(data) {
              hideLoading();
              //$('#project@project.id %}').html(data);
             }
      });
  }
}

//initilize
$(function(){ProjectShow.init();});