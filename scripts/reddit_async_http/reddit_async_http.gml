/// Place this script in the Async HTTP event of a persistent instance
/// 
/// @jujuadams 2020-01-28

var _http_status = async_load[? "http_status"];
var _status      = async_load[? "status"     ];
var _result      = async_load[? "result"     ];

if (_status == 0)
{
    if (_http_status == 200)
    {
        var _json = json_decode(_result);
        if (_json < 0)
        {
            __reddit_error("Could not decode response JSON, aborting");
        }
        else
        {
            switch(global.__reddit_state)
            {
                case REDDIT_STATE.EXCHANGING_AUTH_CODE:
                    global.__reddit_auth_code     = "";
                    global.__reddit_access_token  = _json[? "access_token" ];
                    global.__reddit_token_type    = _json[? "token_type"   ];
                    global.__reddit_expires       = current_time + 900*_json[? "expires_in"]; //Convert seconds to milliseconds, and expire a bit early
                    global.__reddit_refresh_token = _json[? "refresh_token"];
                    global.__reddit_scope         = _json[? "scope"        ];
                    global.__reddit_access_token_received = true;
                    
                    __reddit_message("Received access token \"", global.__reddit_access_token, "\", expires ", global.__reddit_expires);
                    __reddit_message("Ready to make requests!");
                    
                    global.__reddit_state = REDDIT_STATE.ACCESS_TOKEN_RECEIVED;
                    
                    if (script_exists(global.__reddit_callback)) script_execute(global.__reddit_callback, _json);
                break;
                
                case REDDIT_STATE.REFRESHING_ACCESS_TOKEN:
                    global.__reddit_access_token = _json[? "access_token"];
                    global.__reddit_token_type   = _json[? "token_type"  ];
                    global.__reddit_expires      = current_time + 900*_json[? "expires_in"]; //Convert seconds to milliseconds, and expire a bit early
                    global.__reddit_scope        = _json[? "scope"       ];
                    
                    __reddit_message("Received refreshed access token \"", global.__reddit_access_token, "\", expires ", global.__reddit_expires);
                    __reddit_message("Ready to make requests!");
                    
                    global.__reddit_state = REDDIT_STATE.ACCESS_TOKEN_RECEIVED;
                break;
                
                case REDDIT_STATE.OPERATION_PENDING:
                    __reddit_message("Operation complete");
                    global.__reddit_state = REDDIT_STATE.ACCESS_TOKEN_RECEIVED;
                    
                    if (script_exists(global.__reddit_callback)) script_execute(global.__reddit_callback, _json);
                break;
                
                default:
                    __reddit_message("Warning! Unexpected async HTTP event received");
                break;
            }
            
            ds_map_destroy(_json);
        }
    }
    else
    {
        __reddit_message(_result);
        __reddit_error("HTTP " + string(_http_status) + " received. Check output log for more details");
        
        //Ensure the localhost server is destroyed
        __reddit_server_destroy();
        
        if (global.__reddit_state == REDDIT_STATE.OPERATION_PENDING)
        {
            global.__reddit_state = REDDIT_STATE.ACCESS_TOKEN_RECEIVED;
        }
        else
        {
            global.__reddit_state = REDDIT_STATE.INITIALISED;
        }
        
        var _map = ds_map_create();
        if (script_exists(global.__reddit_callback)) script_execute(global.__reddit_callback, _map);
        ds_map_destroy(_map);
    }
}