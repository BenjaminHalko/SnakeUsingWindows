/// @desc
var _size = display_get_height()/HEIGHT;
var _extra = display_get_width() mod WIDTH;
if(isApple)
{
	ini_open("info.txt");
	var _newAppleX = ini_read_real("apple","x",appleX);
	var _newAppleY = ini_read_real("apple","y",appleY);
	if(keyboard_check_pressed(vk_up)) ini_write_real("key","up",true);
	if(keyboard_check_pressed(vk_down)) ini_write_real("key","down",true);
	if(keyboard_check_pressed(vk_left)) ini_write_real("key","left",true);
	if(keyboard_check_pressed(vk_right)) ini_write_real("key","right",true);
	ini_close();
	
	if(_newAppleX != appleX or _newAppleY != appleY)
	{
		appleX = _newAppleX;
		appleY = _newAppleY;
		appleSize = 0;
	}
}
else if(!freeze)
{
	var _lastDir = moveDir;
	if(keyboard_check_pressed(vk_up) and moveDir != 3) moveDir = 1;
	else if(keyboard_check_pressed(vk_left) and moveDir != 0) moveDir = 2;
	else if(keyboard_check_pressed(vk_down) and moveDir != 1) moveDir = 3;
	else if(keyboard_check_pressed(vk_right) and moveDir != 2) moveDir = 0;
	
	ini_open("info.txt");
	if(ini_read_real("key","up",false))
	{
		if(moveDir != 3) moveDir = 1;
		ini_write_real("key","up",false);
	} else if(ini_read_real("key","left",false))
	{
		if(moveDir != 0) moveDir = 2;
		ini_write_real("key","left",false);
	} else if(ini_read_real("key","down",false))
	{
		if(moveDir != 1) moveDir = 3;
		ini_write_real("key","down",false);
	} else if(ini_read_real("key","right",false))
	{
		if(moveDir != 2) moveDir = 0;
		ini_write_real("key","right",false);
	}
	ini_close();
	
	if(_lastDir != moveDir)
	{
		if(WillCrash()) moveDir = _lastDir;
		else alarm[0] = 1;
	}
}
else
{
	ini_open("info.txt");
	frames = ini_read_real("global","frames",frames);
	if(keyboard_check_pressed(vk_up)) ini_write_real("key","up",true);
	if(keyboard_check_pressed(vk_down)) ini_write_real("key","down",true);
	if(keyboard_check_pressed(vk_left)) ini_write_real("key","left",true);
	if(keyboard_check_pressed(vk_right)) ini_write_real("key","right",true);
	ini_close();
	
	lengthOfRectangle = min(lengthOfRectangle,endLengthOfRectangle,endLengthOfRectangle+endFrame-frames+endExtra);
	if(lengthOfRectangle <= 0) game_end();
}

if(isApple or !dead) and (!SuperFileExists()) game_end();

//Move Window
if(!isApple)
{
	var _x,_y,_w,_h;
	
	if(dir == 0 or dir == 2)
	{
		_w = lengthOfRectangle;
		_h = 1;
	}
	else
	{
		_w = 1;
		_h = lengthOfRectangle;
	}

	if(dir == 0) _x = headX-_w+1;
	else _x = headX;

	if(dir == 3) _y = headY-_h+1;
	else _y = headY;

	window_set_rectangle(_x*_size-_extra,_y*_size,_w*_size,_h*_size);
	display_set_gui_size(_w*_size,_h*_size);
}
else
{
	appleSize = min(1,appleSize+0.1);
	var _value = lerp(_size/2,0.5+sin(current_time/1000*pi/2)/2*10,appleSize);
	window_set_rectangle(appleX*_size+_value-_extra,appleY*_size+_value,_size-_value*2,_size-_value*2);
}

if(file_exists("border.txt"))
{
	var _file = file_text_open_read("border.txt");
	if(file_text_read_real(_file) != window_get_showborder()) window_set_showborder(file_text_read_real(_file));
	file_text_close(_file);
}