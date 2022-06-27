/// @desc Frame
alarm[1] = -1;
if(freeze) exit;
spd = max(18-length/3,5);

if(moveDir == -1)
{
	alarm[0] = room_speed/2;
	if(image_blend == c_yellow) image_blend = c_black;
	else image_blend = c_yellow;
	exit;
}
else if(image_blend == c_black) image_blend = c_yellow;

if(dead)
{
	if(length == 1)
	{
		instance_create_layer(0,0,layer,oGame);
		instance_destroy();
	}
	else
	{
		ini_open("info.txt");
		frames++;
		length--;
		ini_write_real("global","frames",frames);
		ini_write_real("global","length",length);
		lengthOfRectangle = min(lengthOfRectangle,length);
		alarm[0] = 3;
		if(length == 1)
		{
			SuperFileDelete();
			alarm[0] = room_speed;
		}
		
		if(ini_read_real("color","snake",c_red) == c_red) ini_write_real("color","snake",make_color_rgb(160,0,0));
		else ini_write_real("color","snake",c_red);
	
		for(var i = 0; i < WIDTH; i++)
		{
			for(var j = 0; j < HEIGHT; j++)
			{
				if(grid[# i,j] > 0) grid[# i,j]--;
			}
		}
		ini_open("info.txt");
	}
}
else if(!appleInit)
{
	ini_open("info.txt");
	appleInit = !ini_read_real("apple","init",true);
	ini_close();
	alarm[0] = 1;
}
else
{
	ini_open("info.txt");
	frames++;

	var _originalX = headX;
	var _originalY = headY;

	//Move
	if(moveDir == 0) headX++;
	else if(moveDir == 1) headY--;
	else if(moveDir == 2) headX--;
	else if(moveDir == 3) headY++;

	//Loop
	if(headX >= WIDTH)
	{
		headX = 0;
		freeze = true;
	} else if(headX < 0)
	{
		headX = WIDTH-1;
		freeze = true;
	} else if(headY >= HEIGHT)
	{
		headY = 0;
		freeze = true;
	} else if(headY < 0)
	{
		headY = HEIGHT-1;
		freeze = true;
	}
	
	//Pickup Apple
	if(appleX == headX and appleY == headY)
	{
		audio_play_sound(sPowerup,1,false);
		frames-=4;
		length+=4;
		ini_write_real("global","length",length);
		if(length >= WIDTH*HEIGHT) dead = true;
		else
		{
			while((appleX == headX and appleY == headY) or grid[# appleX,appleY] > 0)
			{
				appleX = irandom(WIDTH-1);
				appleY = irandom(HEIGHT-1);
			}
		}
		ini_write_real("apple","x",appleX);
		ini_write_real("apple","y",appleY);
		for(var i = 0; i < WIDTH; i++)
		{
			for(var j = 0; j < HEIGHT; j++)
			{
				if(grid[# i,j] > 0) grid[# i,j]+=4;
			}
		}
		snakeColor = appleColor;
		while(snakeColor == appleColor) appleColor = COLORS;
		ini_write_real("color","apple",appleColor);
		ini_write_real("color","snake",snakeColor);
		ini_close();
		ini_open("score.txt");
		var _score = ini_read_real("score","score",0);
		ini_write_real("score","score",++_score);
		ini_write_real("score","hiscore",max(ini_read_real("score","hiscore",HISCORE),_score));
		ini_close();
		ini_open("info.txt");
	}
	
	//DIE!!!
	if(grid[# headX,headY] > 0)
	{
		headX = _originalX;
		headY = _originalY;
		dead = true;
		frames--;
		lengthOfRectangle--;
		freeze = false;
		audio_play_sound(sDeath,1,false);
	}

	//Turn and freeze
	if(!dead and moveDir != dir)
	{
		if(lengthOfRectangle > 1) freeze = true;
		else dir = moveDir;
	}
	
	for(var i = 0; i < WIDTH; i++)
	{
		for(var j = 0; j < HEIGHT; j++)
		{
			if(grid[# i,j] > 0) grid[# i,j]--;
		}
	}
	grid[# headX,headY] = length;

	if(freeze)
	{
		endFrame = frames;
		endExtra = length-lengthOfRectangle-1;
		endLengthOfRectangle = lengthOfRectangle;
		ini_write_string("global","grid",ds_grid_write(grid));
		ds_grid_destroy(grid);
		ini_write_real("head","x",headX);
		ini_write_real("head","y",headY);
		ini_write_real("dir","dir",moveDir);
		ini_write_real("color","snake",snakeColor);
		ini_write_real("apple","x",appleX);
		ini_write_real("apple","y",appleY);
		ini_write_real("global","length",length);
		headX = _originalX;
		headY = _originalY;
	}

	ini_write_real("global","frames",frames);

	if(!freeze)
	{
		if(!dead)
		{
			alarm[0] = spd;
			if(Cornered()) alarm[0] = 1;
			else if(WillCrash()) alarm[0] = room_speed;
		} else alarm[0] = room_speed;
	}
	else CreateWindow();
	lengthOfRectangle = min(length,lengthOfRectangle+1);
	ini_close();
}