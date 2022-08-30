#include "splashkit.h"

int main()
{
	open_window("Example Game",600,400);
	while(!quit_requested() && !key_typed(ESCAPE_KEY))
	{
		clear_screen(COLOR_BLUE);
		refresh_screen(60);
		process_events();
        write_line("why wont the action run :(")
	}

    return 1;
}