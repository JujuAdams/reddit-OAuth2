if (keyboard_check_pressed(ord("1")))
{
    //Start the authorisation flow, see: https://github.com/reddit-archive/reddit/wiki/OAuth2
    //We execute callback_test() once we're authorised
    reddit_start_auth("submit", false, "http://www.jujuadams.com/", callback_submit_to_reddit);
}

//Run some update logic. This keeps access tokens active etc.
reddit_step();