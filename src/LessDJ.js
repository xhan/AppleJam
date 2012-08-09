Jam.define("dj",function(){
    
    var exec = function(msg,params){
        Jam.send("Player."+msg,params);
    }
    
    var player = {
    	track : null,
    	location : 0,
        isPlaying: false,
        isWaiting: false,
        togglePlay: function(){
        	exec("togglePlay");
        },
        nextTrack: function(){
        	exec("nextTrack");
        },
        changeVolume: function(volume){
        	exec("changeVolume",volume);
        },
        changeProgress: function(progress){
        	exec("changeProgress",progress);
        },
        closeWindow: function() {
        	exec("closeWindow");
        },
        minimizeWindow: function(){
        	Jam.send("Player.minimizeWindow");
        },
        showChannelList: function(){
        	Jam.send("Player.showChannelList");
        },
        getSongLength: function(){
        	if (player.track && player.track.length && +player.track.length > 0)
        		return +player.track.length;
        	else return 0;
        },
        getProgress: function(){
        	// Math.ceil
        	var length = player.getSongLength();
        	if(length) return player.location / length;
        	else return 0;	
        },
        onSongChanged: function(){
            
        }
        
    };
    
    var cb_song_changed = null;
    var cb_channel_changed = null;
    var cb_artwork_changed = null;
    var cb_player_state_changed = null;
    
    return {
        player:player,
        
    };
});



var app_song_changed = function(track)
{
	// alert(track);
	player.track = track;
	if(cb_song_changed)
		cb_song_changed.call(this,track);
}

var app_artwork_changed = function(url)
{
	if(cb_artwork_changed)
		cb_artwork_changed.call(this,track);
}

var app_channel_changed = function(index){
	if(cb_channel_changed)
		cb_channel_changed.call(this,index);
}

/* return true if isPlaying */
var app_player_state_change = function(isPlaying,isWaiting){
	if(isPlaying != null)	player.isPlaying = isPlaying;
	if(isWaiting != null)   player.isWaiting = isWaiting;	
	if (cb_player_state_changed)
		cb_player_state_changed.call(this);
}

var app_player_location_changed = function(location){
	player.location = location;
}
