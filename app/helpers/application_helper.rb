module ApplicationHelper

def title page_title
  content_for(:title, page_title)
end
def menu current_menu
  content_for(:menu, current_menu)
end

def link_to_show title, div_id, *args
  extra = ''
  unless args.empty?
    args[0].each{|key,value| extra = extra + " #{key}=\"#{value}\""}
  end
  puts extra
  %(<a href="#" onclick="$('##{div_id}').toggle();return false;"#{extra}>#{title}</a>)
end

def javascript jsname
  jsname = ",#{jsname}" if content_for?(:javascripts)
  content_for(:javascripts, jsname)
end
def stylesheet cssname
  cssname = ",#{cssname}" if content_for?(:stylesheets)
  content_for(:stylesheets, cssname)
end

end
