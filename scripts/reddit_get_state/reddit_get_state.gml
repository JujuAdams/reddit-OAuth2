/// Returns the current operation state of the library, using the REDDIT_STATE enum
/// 
/// @jujuadams 2020-01-28

enum REDDIT_STATE
{
    INITIALISED,
    AUTHORISATION_PENDING,
    EXCHANGING_AUTH_CODE,
    ACCESS_TOKEN_RECEIVED,
    REFRESHING_ACCESS_TOKEN,
    OPERATION_PENDING,
}

return global.__reddit_state;