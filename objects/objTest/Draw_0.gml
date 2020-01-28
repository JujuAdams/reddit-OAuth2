if (reddit_has_access_token())
{
    if (reddit_is_ready())
    {
        draw_text(10, 10, "Access token received, ready to make requests");
    }
    else if (reddit_is_pending())
    {
        draw_text(10, 10, "Operation pending");
    }
}
else switch(reddit_get_state())
{
    case REDDIT_STATE.INITIALISED:
        draw_text(10, 10, "Press <1> to begin authorisation");
    break;
    
    case REDDIT_STATE.AUTHORISATION_PENDING:
        draw_text(10, 10, "Waiting for response from web page");
    break;
}