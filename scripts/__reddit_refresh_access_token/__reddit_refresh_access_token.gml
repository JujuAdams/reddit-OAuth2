/// @jujuadams 2020-01-28

if (global.__reddit_state != REDDIT_STATE.ACCESS_TOKEN_RECEIVED)
{
    __reddit_error("Cannot refresh access token right now");
    return -1;
}

var _body  = "grant_type=refresh_token";
    _body += "&refresh_token=" + global.__reddit_refresh_token;

var _header_map = ds_map_create();
_header_map[? "Authorization"] = "Basic " + base64_encode(global.__reddit_client_id + ":" + global.__reddit_client_secret);
_header_map[? "User-Agent"   ] = REDDIT_USERAGENT;

var _result = http_request("https://www.reddit.com/api/v1/access_token", "POST", _header_map, _body);

ds_map_destroy(_header_map);

__reddit_message("Sent HTTP POST to refresh access token");

global.__reddit_state    = REDDIT_STATE.REFRESHING_ACCESS_TOKEN;
global.__reddit_callback = -1;

return _result;