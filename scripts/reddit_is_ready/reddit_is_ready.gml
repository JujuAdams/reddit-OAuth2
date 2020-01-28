/// Returns whether the API is ready to attempt another query to the Reddit API
/// 
/// @jujuadams 2020-01-28

return ((global.__reddit_state == REDDIT_STATE.ACCESS_TOKEN_RECEIVED) && reddit_has_access_token());