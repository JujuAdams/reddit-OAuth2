/// Submits a text post to a subreddit
/// 
/// @param subreddit
/// @param title
/// @param text
/// @param callback  A script to call when the async event is returned
/// 
/// @jujuadams 2020-01-28

var _subreddit = argument0;
var _title     = argument1;
var _text      = argument2;
var _callback  = argument3;

var _body  = "api_type=json";
    _body += "&kind=self";
    _body += "&sr=" + __reddit_percent_encode(_subreddit);
    _body += "&text=" + __reddit_percent_encode(_text);
    _body += "&title=" + __reddit_percent_encode(_title);

return reddit_http("POST", "https://oauth.reddit.com/api/submit", _body, _callback);