$(document).ready(function(){
	$('.youtube_link input').keyup(function(){
		var val = $(this).val();
		var parts = $(this).val().split('/');
		var code = parts[parts.length-1]
		var url = 'https://www.googleapis.com/youtube/v3/videos?id=' + code +'&key=AIzaSyBCmBZZ40i6f-O6TPFP-SewphojR42VxR0&part=status'
		$.ajax({
		  url: url,
		  context: document.body
		}).done(function(data) {
		  var item = data['items'][0];
		  console.log(item);
		  if(item){
		  	var embeddable = item['status']['embeddable'];
		  	if(embeddable){
		  		var embed = '<iframe width="444" height="250" src="https://www.youtube.com/embed/' + code + '" frameborder="0" allowfullscreen></iframe>';
				$('.youtube_link .video_preview').html(embed);
		  	}
		  	else{
		  		$('.youtube_link .video_preview').html('<p>Это видео нельзя встроить</p>');
		  	}
		  }
		  else{
		    $('.youtube_link .video_preview').html('<p>Такого видео нету</p>');
		  }
		});		
	});
});