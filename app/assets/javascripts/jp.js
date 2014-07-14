function play_song(audio_id) {
        $.ajax({
            url:"<%=url_for :controller => 'application_controller',:action => 'action_find_music'%>",
            data:'audio_id=' + encodeURIComponent(audio_id),
            cache:false,
            success:function (data) {
                var json1 = eval(data);
                songs(json1);  //call to the 2nd function to play song
            }
        })
    }

function songs(json1) {
        $('#play_song').fadeOut('slow');
        $('#play_song').fadeIn('slow');
        $("#jquery_jplayer_1").jPlayer("destroy");
        var audio_url_inside = json1.audio_url;
        $('#your-playlist').append(msg);
        $('#jquery_jplayer_1').jPlayer({
            ready:function (event) {
                $(this).jPlayer("setMedia", {
                    mp3:audio_url_inside
                }).jPlayer("play");   //attemp to play media
            },
            swfPath:"<%= asset_path('Jplayer.swf')%>",
            supplied:"mp3"
        });
    }

