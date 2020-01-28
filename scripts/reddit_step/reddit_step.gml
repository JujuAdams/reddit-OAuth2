/// Place this script in the Step event of a persistent instance
/// 
/// @jujuadams 2020-01-28

switch(global.__reddit_state)
{
    case REDDIT_STATE.AUTHORISATION_PENDING:
    case REDDIT_STATE.EXCHANGING_AUTH_CODE:
        if (current_time > global.__reddit_expires)
        {
            __reddit_error("Authorisation flow expired");
            __reddit_reset(true);
        }
    break;
    
    case REDDIT_STATE.ACCESS_TOKEN_RECEIVED:
        if (current_time > global.__reddit_expires)
        {
            if (global.__reddit_refresh_token == undefined)
            {
                __reddit_message("Access token has expired. Please re-authorise using reddit_start_auth()");
                __reddit_reset(false);
            }
            else
            {
                __reddit_refresh_access_token();
            }
        }
    break;
    
    case REDDIT_STATE.OPERATION_PENDING:
    break;
}