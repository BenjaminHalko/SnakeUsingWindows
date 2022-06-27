/// @desc
#macro HEIGHT 18
#macro WIDTH ceil(display_get_width()/display_get_height()*HEIGHT)

#macro HISCORE 20

#macro COLORS choose(c_aqua,c_yellow,c_red,c_blue,c_lime,c_fuchsia,make_color_rgb(255,0,255),make_color_rgb(255,60,0),make_color_rgb(255,0,60),make_color_rgb(0,255,60),make_color_rgb(60,255,0),make_color_rgb(0,60,255),make_color_rgb(60,0,255))
randomize();

image_blend = c_yellow;

if(os_type == os_linux)
{
	if(file_exists("border.txt"))
	{
		var _file = file_text_open_read("border.txt");
		if(file_text_read_real(_file) != window_get_showborder()) window_set_showborder(file_text_read_real(_file));
		file_text_close(_file);
	}
	else window_set_showborder(false);
}

if(!SuperFileExists())
{
	file_delete("border.txt");
	file_delete("info.txt");
	ini_open("info.txt");
	ini_write_real("color","snake",COLORS);
	ini_write_real("color","apple",COLORS);
	while(ini_read_real("color","snake",c_black) == ini_read_real("color","apple",c_black))
	ini_write_real("color","apple",COLORS);
	ini_close();
	surface_resize(application_surface,512,512);
	room_goto(rTitle);
	isApple = true;
	exit;
}

ini_open("info.txt");
appleX = ini_read_real("apple","x",irandom(WIDTH-1));
appleY = ini_read_real("apple","y",irandom(HEIGHT-1));
isApple = ini_read_real("apple","init",false);
blend = COLORS;

if(isApple)
{
	appleSize = 0;
	ini_write_real("apple","init",false);
}
else
{
	grid = ds_grid_create(WIDTH,HEIGHT);
	ds_grid_clear(grid,0);
	var _gridstring = ini_read_string("global","grid","");
	if(_gridstring != "") ds_grid_read(grid,_gridstring);
	dir = ini_read_real("dir","dir",-1);
	frames = ini_read_real("global","frames",0);
	length = ini_read_real("global","length",12);

	headX = ini_read_real("head","x",irandom(WIDTH-1));
	headY = ini_read_real("head","y",irandom(HEIGHT-1));
	
	appleColor = ini_read_real("color","apple",COLORS);
	snakeColor = ini_read_real("color","snake",COLORS);
	
	appleInit = true;
	if(frames == 0)
	{
		while(appleX == headX and appleY == headY)
		{
			appleX = irandom(WIDTH-1);
			appleY = irandom(HEIGHT-1);
		}
		ini_write_real("apple","x",appleX);
		ini_write_real("apple","y",appleY);
		ini_write_real("apple","init",true);
		appleInit = false;
		
		ini_close();
		CreateWindow();
	}

	spd = max(18-length/2,3);
	endFrame = frames;
	endExtra = 0;
	lengthOfRectangle = 1;
	endLengthOfRectangle = 0;
	moveDir = dir;
	freeze = false;
	dead = false;

	alarm[0] = spd;
	if(Cornered()) alarm[0] = 1;
	else if(WillCrash()) alarm[0] = room_speed;
}

ini_close();