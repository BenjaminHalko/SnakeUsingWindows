function SuperFileCreate()
{
	if(os_type == os_linux)
	{
		var _file = file_text_open_write("SuperFile.txt");
		file_text_write_string(_file,"hi");
		file_text_close(_file);
	}
	else SaveFile();
}

function SuperFileExists()
{
	if(os_type == os_linux) return file_exists("SuperFile.txt");
	else return Exists();
}

function SuperFileDelete()
{
	if(os_type == os_linux) file_delete("SuperFile.txt");
	else RemoveFile();
}

function CreateWindow()
{
	if(os_type == os_linux) execute_shell("\""+program_directory+"Snake_Using_Windows\"", false);
	else execute_shell("\""+program_directory+"Snake Using Windows.exe\"", false);
}

function WillCrash()
{
	var _nextX = headX;
	var _nextY = headY;
	if(moveDir == 0) _nextX++;
	else if(moveDir == 1) _nextY--;
	else if(moveDir == 2) _nextX--;
	else if(moveDir == 3) _nextY++;
			
	//Loop
	if(_nextX >= WIDTH) _nextX = 0;
	else if(_nextX < 0) _nextX = WIDTH-1;
	else if(_nextY >= HEIGHT) _nextY = 0;
	else if(_nextY < 0) _nextY = HEIGHT-1;
	
	return (grid[# _nextX,_nextY] > 0);
}

function Cornered()
{
	for(var i = 0; i < 4; i++)
	{
		var _nextX = headX;
		var _nextY = headY;
		if(i == 0) _nextX++;
		else if(i == 1) _nextY--;
		else if(i == 2) _nextX--;
		else if(i == 3) _nextY++;
			
		//Loop
		if(_nextX >= WIDTH) _nextX = 0;
		else if(_nextX < 0) _nextX = WIDTH-1;
		else if(_nextY >= HEIGHT) _nextY = 0;
		else if(_nextY < 0) _nextY = HEIGHT-1;
	
		if(grid[# _nextX,_nextY] <= 0) return false;
	}
	
	return true;
}