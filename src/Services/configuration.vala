/**
 * 
 */
public class Services.Configuration {
	string config_string;
	string pass_string;
	string config_dir = GLib.Environment.get_home_dir()+"/.pvpn-cli";

	public Configuration(string username,string tier,string password) {
		init_config(username,tier);
		init_passfile(username,password);
		save_config();
		save_passfile();
	}

	public void init_config(string username,string tier){
		config_string = "[USER]\nusername = "+username+"\ntier = "+tier+"\ndefault_protocol = udp\ninitialized = 1\ndns_leak_protection = 1\ncustom_dns = None\ncheck_update_interval = 3\napi_domain = https://api.protonvpn.ch\nkillswitch = 0\nsplit_tunnel = 0\n\n[metadata]\nlast_api_pull = 0\nlast_update_check = 0";
	}

	public void init_passfile(string username,string password){
		pass_string = username+"\n"+password;
	}

	public void save_config(){
		FileStream stream = FileStream.open (config_dir+"sample.cfg", "w");
		stream.puts(config_string);
	}

	public void save_passfile(){
		FileStream stream = FileStream.open (config_dir+"samplepass", "w");
		stream.puts(pass_string);
	}
	
}