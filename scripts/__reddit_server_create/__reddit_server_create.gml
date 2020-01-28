/// @jujuadams 2020-01-28

if (global.__reddit_localhost_server < 0)
{
    global.__reddit_localhost_server = network_create_server_raw(network_socket_tcp, REDDIT_LOCALHOST_PORT, 10);
}

if (global.__reddit_localhost_server < 0)
{
    __reddit_error("Failed to create raw TCP server on port ", REDDIT_LOCALHOST_PORT);
    return false;
}

__reddit_message("Opened server ", global.__reddit_localhost_server, " on port ", REDDIT_LOCALHOST_PORT);
return true;