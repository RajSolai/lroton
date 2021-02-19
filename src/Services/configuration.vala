/*
 * Copyright (c) 2020 - Today solairaj ()
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: solairaj <msraj085@gmail.com>
 */

public class Services.Configuration {
    string config_string ;
    string pass_string ;
    string config_dir = GLib.Environment.get_home_dir () + "/.pvpn-cli" ;

    public Configuration (string username, string tier, string password) {

        stdout.printf (config_dir) ;

        if( !check_config_dir ()){
            stdout.printf ("Config folder not found") ;
            make_config_dir () ;
        }

        init_config (username, tier) ;
        init_passfile (username, password) ;
        save_config () ;
        save_passfile () ;

    }

    public void init_config(string username, string tier) {
        config_string = "[USER]\nusername = " + username + "\ntier = " + tier + "\ndefault_protocol = udp\ninitialized = 1\ndns_leak_protection = 1\ncustom_dns = None\ncheck_update_interval = 3\napi_domain = https://api.protonvpn.ch\nkillswitch = 0\nsplit_tunnel = 0\n\n[metadata]\nlast_api_pull = 0\nlast_update_check = " + get_current_epoch_time () ;
    }

    public void init_passfile(string username, string password) {
        pass_string = username + "\n" + password ;
    }

    public void save_config() {
        FileStream stream = FileStream.open (config_dir + "/pvpn-cli.cfg", "w") ;
        stream.puts (config_string) ;
    }

    public void save_passfile() {
        FileStream stream = FileStream.open (config_dir + "/pvpnpass", "w") ;
        stream.puts (pass_string) ;
    }

    private bool check_config_dir() {
        string cli_stdout = "" ;
        string cli_stderr = "" ;
        int cli_status = 0 ;
        bool out = false ;
        try {
            Process.spawn_command_line_sync ("ls " + config_dir,
                                             out cli_stdout,
                                             out cli_stderr,
                                             out cli_status) ;
            if( cli_status == 0 ){
                out = true ;
            }
        } catch ( Error e ){
            stdout.printf (e.message) ;
        }
        return out ;
    }

    private void make_config_dir() {
        string cli_stdout = "" ;
        string cli_stderr = "" ;
        int cli_status = 0 ;
        try {
            Process.spawn_command_line_sync ("mkdir " + config_dir,
                                             out cli_stdout,
                                             out cli_stderr,
                                             out cli_status) ;
            stdout.printf ("Config folder Created") ;
        } catch ( Error e ){
            stdout.printf (e.message) ;
        }
    }

    private string get_current_epoch_time() {
        string cli_stdout = "" ;
        string cli_stderr = "" ;
        int cli_status = 0 ;
        try {
            Process.spawn_command_line_sync ("date +%s",
                                             out cli_stdout,
                                             out cli_stderr,
                                             out cli_status) ;
        } catch ( Error e ){
            stdout.printf (e.message) ;
        }
        return cli_stdout ;
    }

}