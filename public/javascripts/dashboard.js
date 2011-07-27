function toggleBlock(id)
{
  $('#task'+id).toggleClass('minimized');
  $('#task'+id+'>.short_desc').toggle();
  $('#task'+id+'>.long_desc').toggle(); 
}

$(function(){
window.userStoryDlg = $('#user_story_dialog').dialog({ width: 400, height: 400, 
    closeOnEscape:true, draggable:false, modal: true, resizable: true, zIndex: 9999999999, 
   autoOpen:false});
});