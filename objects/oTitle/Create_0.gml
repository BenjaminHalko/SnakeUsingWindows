/// @desc
size = 0;
ini_open("score.txt");
Score = "SCORE\n"+string_replace_all(string_format(ini_read_real("score","score",0)*100,4,0)," ","0");
HiScore = "HI-SCORE\n"+string_replace_all(string_format(ini_read_real("score","hiscore",HISCORE)*100,4,0)," ","0");
ini_close();
draw_set_color(c_white);
draw_set_font(Font);
draw_set_halign(fa_center);