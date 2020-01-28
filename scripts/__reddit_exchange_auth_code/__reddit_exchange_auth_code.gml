/// @jujuadams 2020-01-28

if (global.__reddit_state != REDDIT_STATE.AUTHORISATION_PENDING)
{
    __reddit_error("Cannot exchange authorisation code at this time");
    return -1;
}

var _header_map = ds_map_create();
_header_map[? "Authorization"] = "Basic " + base64_encode(global.__reddit_client_id + ":" + global.__reddit_client_secret);
_header_map[? "User-Agent"   ] = REDDIT_USERAGENT;

var _body  = "grant_type=authorization_code";
    _body += "&code=" + global.__reddit_auth_code;
    _body += "&redirect_uri=http://localhost:" + string(REDDIT_LOCALHOST_PORT) + "/";

http_request("https://www.reddit.com/api/v1/access_token", "POST", _header_map, _body);

ds_map_destroy(_header_map);

__reddit_message("Exchanging authorisation code for access token");

global.__reddit_state = REDDIT_STATE.EXCHANGING_AUTH_CODE;

return 0;