/// @param executeCallback

var _execute_callback = argument0;

if (_execute_callback && script_exists(global.__reddit_callback))
{
    var _map = ds_map_create();
    script_execute(global.__reddit_callback, _map);
    ds_map_destroy(_map);
}

__reddit_server_destroy();

global.__reddit_state                 = REDDIT_STATE.INITIALISED;
global.__reddit_callback              = -1;
global.__reddit_access_token_received = false;
global.__reddit_expires               = -1;