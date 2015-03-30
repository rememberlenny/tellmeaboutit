module StoriesHelper
  def render_player recording_url
    frame = '<iframe  class="recording" src="http://www.wnyc.org/widgets/ondemand_player/#file=' + recording_url + '" frameborder="0"> </iframe>'
    raw frame
  end

end
