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

public class Application : Gtk.Application {
    Gtk.Stack main_stack ;
    Services.Protonvpn protonvpn = new Services.Protonvpn () ;
    Dialogs.Error errorDialog ;
    Widgets.Welcome welcome ;
    Widgets.ConnectedBox connection ;
    Widgets.ConfigBox configbox ;
    Widgets.ApplicationHeader hb ;
    GLib.Notification app_notification_success = new GLib.Notification ("Connection Success !") ;

    public Application () {
        Object (
            application_id: "com.github.rajsolai.lroton",
            flags : ApplicationFlags.FLAGS_NONE
            ) ;
    }

    protected override void activate() {

        weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default () ;
        default_theme.add_resource_path ("/com/github/rajsolai/lroton") ;

        // stylesheet
        var provider = new Gtk.CssProvider () ;
        provider.load_from_resource ("/com/github/rajsolai/lroton/stylesheet.css") ;
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION) ;

        var main_window = new Gtk.ApplicationWindow (this) ;

        hb = new Widgets.ApplicationHeader () ;
        welcome = new Widgets.Welcome () ;
        connection = new Widgets.ConnectedBox () ;
        configbox = new Widgets.ConfigBox () ;
        main_stack = new Gtk.Stack () ;

        main_stack.expand = true ;
        main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT ;
        main_stack.add_named (welcome, "welcome_view") ;
        main_stack.add_named (connection, "connection_view") ;
        main_stack.add_named (configbox, "config_view") ;

        welcome.selected.connect ((index) => {
            switch( index ){
            case 0:
                vpnConnection (1) ;
                break ;
            case 1:
                vpnConnection (2) ;
                break ;
            case 2:
                main_stack.visible_child_name = "config_view" ;
                break ;
            default:
                print ("Invalid Option") ;
                break ;
            }
        }) ;

        connection.disconnect_signal.connect (() => {
            vpnDisconnection () ;
        }) ;

        configbox.back_to_welcome.connect (() => {
            main_stack.visible_child_name = "welcome_view" ;
        }) ;

        protonvpn.onstart.connect (() => {
            print ("the connection process is started") ;
            // app_notification_conn.set_body("Hold on! Connecting to VPN Servers");
            // send_notification("lroton_connection",app_notification_conn);
        }) ;

        main_window.get_style_context () ;
        main_window.set_titlebar (hb) ;
        main_window.add (main_stack) ;
        main_window.default_height = 450 ;
        main_window.default_width = 500 ;
        main_window.title = "Lroton" ;
        main_window.show_all () ;
    }

    private void vpnDisconnection() {
        if( protonvpn.disconnect_server ()){
            main_stack.visible_child_name = "welcome_view" ;
        } else {
            errorDialog = new Dialogs.Error (32256) ;
        }
    }

    private void vpnConnection(int mode) {
        var connc_thread = new Thread<int>("main_connection", () => {
            bool cmd = false ;
            if( mode == 1 ){
                cmd = protonvpn.connect_fast_server () ;
            } else if( mode == 2 ){
                cmd = protonvpn.connect_random_server () ;
            } else {
                print ("") ;
            }
            print (cmd.to_string ()) ;
            if( cmd ){
                main_stack.visible_child_name = "connection_view" ;
                print (protonvpn.protonvpn_stdout) ;
                print ("%d", protonvpn.protonvpn_status) ;
                app_notification_success.set_body (protonvpn.protonvpn_stdout) ;
                send_notification ("lroton", app_notification_success) ;
            } else {
                if( protonvpn.protonvpn_status == 256 && protonvpn.protonvpn_stdout != "" ){
                    errorDialog = new Dialogs.Error (404) ;
                } else {
                    print ("the err is %s", protonvpn.protonvpn_stderr) ;
                    print ("the err code is %d", protonvpn.protonvpn_status) ;
                    switch( protonvpn.protonvpn_status ){
                    case 32256:
                        errorDialog = new Dialogs.Error (32256) ;
                        break ;
                    case 32512:
                        errorDialog = new Dialogs.Error (256) ;
                        break ;
                    case 256:
                        errorDialog = new Dialogs.Error (256) ;
                        break ;
                    default:
                        print ("other error found\n") ;
                        break ;
                    }
                }
            }
            return 0 ;
        }) ;
        connc_thread.join () ;
    }

//

    public static int main(string[] args) {
        var app = new Application () ;
        return app.run (args) ;
    }

}

