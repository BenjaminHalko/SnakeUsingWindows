/// @desc
SuperFileDelete();
instance_create_layer(0,0,layer,oGame);
instance_destroy();
if(file_exists("border.txt")) window_set_showborder(false);