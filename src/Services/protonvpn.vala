/**
 * 
 */
public class Services.Protonvpn{
	public string protonvpn_stdout = "";
	public string protonvpn_stderr = "";
	public int protonvpn_status = 0;

	public Protonvpn() {
		
	}

	private string get_path_of_cli(){
        string cli_stdout = "";
        string cli_stderr = "";
        int cli_status = 0;
        Process.spawn_command_line_sync ("which protonvpn",
        out cli_stdout,
        out cli_stderr,
        out cli_status);
        return cli_stdout;
    }

    private void reset_status_vars(){
    	protonvpn_stdout = "";
    	protonvpn_stderr = "";
    	protonvpn_status = 0;
    }

    public bool disconnect_server(){
    	reset_status_vars();
    	Process.spawn_command_line_sync ("pkexec "+get_path_of_cli()+" disconnect",
        out protonvpn_stdout,
        out protonvpn_stderr,
        out protonvpn_status);
        if(protonvpn_status == 0 && protonvpn_stderr == ""){
        	return true;
        }else{
        	return false;
        }
    }

	public bool connect_fast_server(){
		reset_status_vars();
		Process.spawn_command_line_sync ("pkexec "+get_path_of_cli()+" connect -f",
        out protonvpn_stdout,
        out protonvpn_stderr,
        out protonvpn_status);
        if(protonvpn_status == 0 && protonvpn_stderr == ""){
        	return true;
        }else{
        	return false;
        }
	}

	public bool connect_random_server(){
        reset_status_vars();
        Process.spawn_command_line_sync ("pkexec "+get_path_of_cli()+" connect -f",
        out protonvpn_stdout,
        out protonvpn_stderr,
        out protonvpn_status);
        if(protonvpn_status == 0 && protonvpn_stderr == ""){
            return true;
        }else{
            return false;
        }
	}

	public void connectionStatus(){
	    string protonvpn_stdout = "";
	    string protonvpn_stderr = "";
	    int protonvpn_status = 0;
	    try {
	        Process.spawn_command_line_sync ("sudo protonvpn s",
	        out protonvpn_stdout,
	        out protonvpn_stderr,
	        out protonvpn_status);
	        stdout.printf(protonvpn_stdout);
	        stdout.printf(protonvpn_stderr);
	    } catch (Error e) {
	        stdout.printf(e.message);
	    }
    }
	
}