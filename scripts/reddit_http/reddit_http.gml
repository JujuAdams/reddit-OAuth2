/// Queries an endpoint for Reddit's API
/// See: https://github.com/reddit-archive/reddit/wiki/OAuth2
/// 
/// @param method    HTTP method to use
/// @param url       The API endpoint to query
/// @param body      HTTP body, percent encoded where appropriate
/// @param callback  A script to call when the async event is returned
/// 
/// @jujuadams 2020-01-28

if (!reddit_is_ready())
{
    __reddit_error("Cannot begin operation, library isn't ready");
    return -1;
}

var _method   = argument0;
var _url      = argument1;
var _body     = argument2;
var _callback = argument3;

var _header_map = ds_map_create();
_header_map[? "Authorization"] = global.__reddit_token_type + " " + global.__reddit_access_token;
_header_map[? "User-Agent"   ] = REDDIT_USERAGENT;

var _result = http_request(_url, _method, _header_map, _body);

ds_map_destroy(_header_map);

global.__reddit_state    = REDDIT_STATE.OPERATION_PENDING;
global.__reddit_callback = _callback;

return _result;