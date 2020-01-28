/// Starts the authorisation flow for Reddit with the given scope
/// See: https://github.com/reddit-archive/reddit/wiki/OAuth2
/// 
/// This method requires a server to be opened on the local machine using the port defined by REDDIT_LOCALHOST_PORT
/// As a result, it may fail in situations where an aggressive firewall is in place
/// A web page is also opened to authenticate the user with Reddit
/// 
/// @param scope        API scope that the application requires. A list of scopes is below. If you'd like to use more than one scope, put them in a space-separated list e.g. "submit vote wikiread"
/// @param permanent    If set to <true>, the token received from reddit will be kept alive by refreshing the token once an hour
/// @param redirectURL  URL to redirect the browser to once the access token has been received by the game
/// @param callback     The script to call once authorisation has been granted or denied
/// 
/// Valid reddit scopes, from https://github.com/reddit-archive/reddit/wiki/OAuth2:
/// identity, edit, flair, history, modconfig, modflair, modlog, modposts, modwiki, mysubreddits, privatemessages, read, report, save, submit, subscribe, vote, wikiedit, wikiread
/// 
/// @jujuadams 2020-01-28

if (global.__reddit_state != REDDIT_STATE.INITIALISED)
{
    __reddit_error("Cannot request access token again");
    return -1;
}

var _scope        = argument0;
var _permanent    = argument1;
var _redirect_url = argument2;
var _callback     = argument3;

if (!__reddit_server_create()) return -2;

//https://www.reddit.com/api/v1/authorize?client_id=CLIENT_ID&response_type=TYPE&state=RANDOM_STRING&redirect_uri=URI&duration=DURATION&scope=SCOPE_STRING
var _url  = "https://www.reddit.com/api/v1/authorize?";
    _url += "client_id=" + global.__reddit_client_id;
    _url += "&response_type=code";
    _url += "&state=GameMaker%20for%20Reddit";
    _url += "&redirect_uri=http://localhost:" + string(REDDIT_LOCALHOST_PORT) + "/";
    _url += "&duration=" + (_permanent? "permanent" : "temporary");
    _url += "&scope=" + _scope;
url_open(_url);

global.__reddit_state        = REDDIT_STATE.AUTHORISATION_PENDING;
global.__reddit_redirect_url = _redirect_url;
global.__reddit_callback     = _callback;
global.__reddit_expires      = current_time + REDDIT_LOCALHOST_TIMEOUT;

return 0;