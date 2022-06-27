/// @desc
if(!file_exists("border.txt")) and (os_type != os_linux)
{
	window_set_showborder(true);
	window_set_showborder(false);
}
var _file = file_text_open_write("border.txt");
file_text_write_real(_file,!window_get_showborder());
file_text_close(_file);