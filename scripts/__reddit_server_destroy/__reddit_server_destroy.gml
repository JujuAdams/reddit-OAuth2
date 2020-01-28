/// @jujuadams 2020-01-28

if (global.__reddit_localhost_server >= 0)
{
    __reddit_message("Shutting server ", global.__reddit_localhost_server);
    network_destroy(global.__reddit_localhost_server);
    global.__reddit_localhost_server = -1;
}