/// Returns whether the library is currently performing an API endpoint query
/// A result of <false> doesn't necessarily mean the library is ready to make a query, please us reddit_is_read() for that
/// 
/// @jujuadams 2020-01-28

return ((global.__reddit_state == REDDIT_STATE.OPERATION_PENDING) && reddit_has_access_token());