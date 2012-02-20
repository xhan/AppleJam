var Jam = Jam || {};

Jam.importScript = function(path){
	document.write('<script src="'+path+'" type="text/javascript"><\/'+'script>');
};

Jam.send_message = function(msg,params,scheme){
	if(!msg) return;
	scheme = scheme || 'ajam';
	if (!params)
		window.location.href = scheme+':'+msg;
	else
		window.location.href = scheme+':'+msg+'?'+encodeURIComponent(JSON.stringify(params));
};

/*
 document.addEventListener("jam_loaded", onReady, false);
 // AppleJam is ready
 //
 function onReady() {
 // add codes here
 }
 */

(function () {
 var timer = setInterval(function(){
                         var state = document.readyState;
                         if ( ( state == 'loaded' || state == 'complete' ) )
                         {
                         clearInterval(timer);
                         // todo: add constructors to load plugins
                         var e = document.createEvent('Events');
                         e.initEvent('jam_loaded',true,true);
                         document.dispatchEvent(e);
                         }
                         },1);
 })();

// TODO: move this codes to seperate plugins
DJ = {};
// function Track(name,artist,album)
// {
// 	this.album = name|| "";
// 	this.artist = artist||"";
// 	this.name = album||"";
// }

var cb_song_changed = null;
var cb_channel_changed = null;
var cb_artwork_changed = null;
var cb_player_state_changed = null;
// var time_tick = null;
var player = {
	track : null,
	location : 0,
isPlaying: false,
isWaiting: false,
};

player.togglePlay = function(){
	Jam.send_message("Player.togglePlay");
}
player.nextTrack = function(){
	Jam.send_message("Player.nextTrack");
}
player.changeVolume = function(volume){
	Jam.send_message("Player.changeVolume",volume);
}

player.changeProgress = function(progress){
	Jam.send_message("Player.changeProgress",progress);
}

player.closeWindow = function() {
	Jam.send_message("Player.closeWindow");
}

player.minimizeWindow = function(){
	Jam.send_message("Player.minimizeWindow");
}

player.showChannelList = function(){
	Jam.send_message("Player.showChannelList");
}

player.getSongLength = function(){
	if (player.track && player.track.length && +player.track.length > 0)
		return +player.track.length;
	else return 0;
}

player.getProgress = function(){
	// Math.ceil
	var length = player.getSongLength();
	if(length) return player.location / length;
	else return 0;
	
}

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
