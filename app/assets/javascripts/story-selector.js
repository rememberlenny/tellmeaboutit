$('.specific-story').on('click', function(e){
  e.preventDefaults();
  var name = 'Test';
  var audio_url = 'http://api.twilio.com/2010-04-01/Accounts/ACb9f7fef2fed34f1092fd1ceac6b5212a/Recordings/RE285a5a99345a3878f59da8f9aec87ffd'
  var template = "<div class='panel' style='background:#00333f'><div class='row'><h5>" + name + "</h5></div><div class='row'><audio controls><source src=" + audio_url + " type='audio/mpeg'></audio></div><div class='row'><p>Share this story</p></div></div>"
  $('.selected-story').html(template);
});

