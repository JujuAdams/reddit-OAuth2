/// Place this script in the Async Networking event of a persistent instance
/// 
/// @jujuadams 2020-01-28

switch(async_load[? "type"])
{
    case network_type_connect:
        global.__reddit_out_socket = async_load[? "socket"];
        __reddit_message("New connection on socket ", global.__reddit_out_socket);
    break;
    
    case network_type_data:
        var _buffer = async_load[? "buffer"];
        if (_buffer != undefined)
        {
            var _string = buffer_read(_buffer, buffer_string);
            var _a = string_pos("?state=", _string);
            var _b = string_pos("&code=", _string);
            var _c = string_pos(" HTTP/1.1", _string);
            
            if ((_a <= 0) || (_b <= 0) || (_c <= 0))
            {
                show_debug_message(_string);
            }
            else
            {
                global.__reddit_auth_code = string_copy(_string, _b+6, _c - (_b+6));
                __reddit_message("Received authorisation code \"", global.__reddit_auth_code, "\"");
                __reddit_exchange_auth_code();
            }
            
            if (global.__reddit_localhost_server >= 0)
            {
                __reddit_message("Sending raw HTTP response");
                
                var _string = "HTTP/1.1 301 Moved Permanently\nLocation: " + global.__reddit_redirect_url + "\n\n";
                
                var _out_buffer = buffer_create(string_byte_length(_string)+1, buffer_fixed, 1);
                buffer_write(_out_buffer, buffer_string, _string);
                
                network_send_raw(global.__reddit_out_socket, _out_buffer, buffer_get_size(_out_buffer));
                buffer_delete(_out_buffer);
            }
            
            __reddit_server_destroy();
        }
    break;
}