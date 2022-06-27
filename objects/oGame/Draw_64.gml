ini_open("info.txt");
var _color = image_blend;
if(_color = c_yellow)
{
	var _text = "snake";
	if(isApple) _text = "apple";
	blend = ini_read_real("color",_text,blend);
	_color = blend;
}
if(isApple) draw_clear(_color);
else
{
	var _size = display_get_height()/HEIGHT;
	for(var i = 0; i < lengthOfRectangle; i++)
	{
		var _x,_y;
	
		if(dir == 0)
		{
			_x = lengthOfRectangle-i;
			_y = 0;
		}
		else if(dir == 1)
		{
			_y = i;
			_x = 0;
		}
		else if(dir == 2)
		{
			_x = lengthOfRectangle+i;
			_y = 0;
		}
		else if(dir == 3)
		{
			_y = lengthOfRectangle-i;
			_x = 0;
		}
		else
		{
			_x = 0;
			_y = 0;
		}
		
		draw_set_color(c_lime);
		draw_rectangle(_x*_size,_y*_size,_x*_size+_size,_y*_size+_size,false);
	}
}
ini_close();