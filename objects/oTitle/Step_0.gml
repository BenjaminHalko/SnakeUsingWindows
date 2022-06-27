/// @desc
size = min(size+32,512);
window_set_rectangle(display_get_width()/2-size/2,display_get_height()/2-size/2,size,size);
if(keyboard_check_pressed(vk_enter))
{
	SuperFileCreate();
	ini_open("score.txt");
	ini_write_real("score","score",0);
	ini_close();
	room_goto(rGame);
}
else if(keyboard_check_pressed(vk_tab)) url_open("https://ldjam.com/events/ludum-dare/49/snake-using-windows");
else if(keyboard_check_pressed(vk_escape)) game_end();