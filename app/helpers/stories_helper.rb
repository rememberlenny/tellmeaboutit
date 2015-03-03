module StoriesHelper
  def render_player story_id, recording_id
    frame = '<iframe  class="recording"
              src="http://www.wnyc.org/widgets/ondemand_player/#file=http://58c06a9f.ngrok.com/stories/' + story_id.to_s + '/recordings/' + recording_id.to_s + '.xml"
              frameborder="0">
    </iframe>'
    raw frame
  end

end
