/// Initialises the Reddit library
/// You can find your clientID and clientSecret via the Developed Application page on Reddit's backend:
/// https://www.reddit.com/prefs/apps
///
/// @param clientID      Provided by Reddit
/// @param clientSecret  Provided by Reddit
/// 
/// @jujuadams 2020-01-28

show_debug_message("Welcome to the Reddit library by @jujuadams! v" + __REDDIT_VERSION + " " + __REDDIT_DATE);

if (!code_is_compiled() && !REDDIT_IGNORE_YYC_WARNING)
{
    __reddit_error("It's very easy to extract strings from GameMaker VM builds.\nPlease use YYC to build games for public release.");
}

global.__reddit_client_id     = argument0;
global.__reddit_client_secret = argument1;

global.__reddit_state                 = REDDIT_STATE.INITIALISED;
global.__reddit_access_token_received = false;
global.__reddit_callback              = -1;
global.__reddit_localhost_server      = -1;
global.__reddit_scope                 = "";

#macro __REDDIT_VERSION  "1.0.0"
#macro __REDDIT_DATE     "2020/01/28"