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

public class Services.Protonvpn {
    public string protonvpn_stdout = "" ;
    public string protonvpn_stderr = "" ;
    public int protonvpn_status = 0 ;

    public Protonvpn () {

    }

    private void refresh_pvpn() {
        try {
            Process.spawn_command_line_async (get_path_of_cli () + " refresh") ;
        } catch ( Error e ){
            stdout.printf (e.message) ;
        }
    }

    private string get_path_of_cli() {
        var gpc_thread = new Thread<string>("get_path", () => {
            string cli_stdout = "" ;
            string cli_stderr = "" ;
            int cli_status = 0 ;
            try {
                Process.spawn_command_line_sync ("which protonvpn",
                                                 out cli_stdout,
                                                 out cli_stderr,
                                                 out cli_status) ;
            } catch ( Error e ){
                stdout.printf (e.message) ;
            }
            return cli_stdout ;
        }) ;
        string path = gpc_thread.join () ;
        return path ;
    }

    private void reset_status_vars() {
        protonvpn_stdout = "" ;
        protonvpn_stderr = "" ;
        protonvpn_status = 0 ;
    }

    public bool disconnect_server() {
        reset_status_vars () ;
        var dcs_thread = new Thread<bool>("disconnect_server", () => {
            bool out = false ;
            try {
                Process.spawn_command_line_sync ("pkexec " + get_path_of_cli () + " disconnect",
                                                 out protonvpn_stdout,
                                                 out protonvpn_stderr,
                                                 out protonvpn_status) ;
                if( protonvpn_status == 0 && protonvpn_stderr == "" ){
                    out = true ;
                } else {
                    out = false ;
                }
            } catch ( Error e ){
                stdout.printf (e.message) ;
            }
            return out ;
        }) ;
        bool result = dcs_thread.join () ;
        return result ;
    }

    public bool connect_fast_server() {
        refresh_pvpn () ;
        reset_status_vars () ;
        onstart () ;
        var cdf_thread = new Thread<bool>("connect_fast_server", () => {
            bool out = false ;
            try {
                Process.spawn_command_line_sync ("pkexec " + get_path_of_cli () + " connect -f",
                                                 out protonvpn_stdout,
                                                 out protonvpn_stderr,
                                                 out protonvpn_status) ;
                if( protonvpn_status == 0 && protonvpn_stderr == "" ){
                    out = true ;
                    print ("connected to server") ;
                } else {
                    out = false ;
                }
            } catch ( Error e ){
                print (e.message) ;
            }
            return out ;
        }) ;
        bool result = cdf_thread.join () ;
        return result ;
    }

    public bool connect_random_server() {
        refresh_pvpn () ;
        reset_status_vars () ;
        onstart () ;
        var crs_thread = new Thread<bool>("connect_random", () => {
            bool out = false ;
            try {
                Process.spawn_command_line_sync ("pkexec " + get_path_of_cli () + " connect -r",
                                                 out protonvpn_stdout,
                                                 out protonvpn_stderr,
                                                 out protonvpn_status) ;
                if( protonvpn_status == 0 && protonvpn_stderr == "" ){
                    out = true ;
                } else {
                    out = false ;
                }
            } catch ( Error e ){
                stdout.printf (e.message) ;
            }
            return out ;
        }) ;
        bool result = crs_thread.join () ;
        return result ;
    }

    public void connectionStatus() {
        string protonvpn_stdout = "" ;
        string protonvpn_stderr = "" ;
        int protonvpn_status = 0 ;
        try {
            Process.spawn_command_line_sync ("sudo protonvpn s",
                                             out protonvpn_stdout,
                                             out protonvpn_stderr,
                                             out protonvpn_status) ;
            stdout.printf (protonvpn_stdout) ;
            stdout.printf (protonvpn_stderr) ;
        } catch ( Error e ){
            stdout.printf (e.message) ;
        }
    }

    public signal void onstart() ;

}