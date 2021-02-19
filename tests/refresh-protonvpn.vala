public static void main (string[] args) {
	try {
		Process.spawn_command_line_async ("protonvpn refresh");
	} catch (SpawnError e) {
		print ("Error: %s\n", e.message);
	}
}