/// This callback is executed once the authorisation flow has been completed. Completed doesn't necessarily mean successful!
/// 
/// @param RedditJSON  The JSON returned by Reddit after a query has completed

var _json = argument0; //Not used in this script

if (reddit_has_access_token())
{
    if (show_question("Success!\n\nWould you like to submit to reddit?"))
    {
        var _text  = "Recently, I've been experimenting with communicating with [REST APIs](https://medium.com/extend/what-is-rest-a-simple-explanation-for-beginners-part-1-introduction-b4a072f8740f) using native GML. It all started with /u/ShaunJS asking me to [implement OAuth2 for YouTube](https://twitter.com/shaunspalding/status/1218699808141127685?s=20). After that, I got [OAuth1.0a working with Twitter](https://twitter.com/jujuadams/status/1219017410025607176?s=20).";
            _text += "\n";
            _text += "\n&nbsp;\n";
            _text += "\n[reddit's API](https://www.reddit.com/dev/api) is similar to both YouTube and Twitter so it didn't take too much to build the OAuth2 flow that reddit uses. The documentation is very broad but it's not particularly clear, but it's definitely usable. The library I've built demonstrates authorisation but isn't a full implementation of the reddit API, but it's extensible to cover whatever you might need.";
            _text += "\n";
            _text += "\n&nbsp;\n";
            _text += "\nThe code for this test post (minus my dev credentials!) can be found on GitHub, free and open source forever: https://github.com/JujuAdams/reddit-OAuth2";
            _text += "\n";
            _text += "\n&nbsp;\n";
            _text += "\nIf you'd like to keep in touch, [please follow me on Twitter](https://www.twitter.com/jujuadams) or [shoot me an email](https://www.jujuadams.com/)";
        
        reddit_api_submit_text("test", "This post was made from inside a GameMaker game using pure native GML.", _text, callback_announce_result);
    }
}