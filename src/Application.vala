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
    Gtk.Button random_connect_btn;
    Gtk.Button connect_btn;
    Gtk.Button settings_btn;
    Gtk.Image connection_icon;
    Gtk.Label connection_label;
    Gtk.Label connection_status;
    Settings settings;
    bool status;
  

    public Application () {
        Object (
            application_id: "com.github.rajsolai.lroton",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        clearConnection();
        // stylesheet
        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/com/github/rajsolai/lroton/stylesheet.css");
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        //
        var config_btn = new Gtk.Button.with_label("Configure");
        config_btn.clicked.connect (()=>{
            new Settings();
        });
        var menu_list = new Gtk.Grid();
        menu_list.add(config_btn);
        menu_list.show_all();
        var menu_popover = new Gtk.Popover(null);
        menu_popover.add(menu_list);
        var menu_button = new Gtk.MenuButton ();
        menu_button.set_can_focus (false);
        menu_button.image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        menu_button.popover = menu_popover;        
        //
        connect_btn = new Gtk.Button.from_icon_name("network-vpn",Gtk.IconSize.LARGE_TOOLBAR);
        connect_btn.set_tooltip_text("Connect to Fastest VPN Server");        
        connect_btn.clicked.connect (() => {
            fastConnection();
        });
        //
        var hb = new Gtk.HeaderBar();
        hb.set_show_close_button(true);
        hb.pack_start(connect_btn);
        hb.pack_end(menu_button);
        //
        var main_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        connection_icon = new Gtk.Image ();
        connection_icon.gicon = new ThemedIcon ("emblem-unreadable");//emblem-unreadable
        connection_icon.pixel_size = 128;
        connection_label = new Gtk.Label("Your Connection is Not Secure");
        connection_label.get_style_context().add_class("h2");
        connection_status = new Gtk.Label("");
        connection_label.get_style_context().add_class("h2");
        main_box.pack_start(connection_icon,false,false,80);
        main_box.pack_start(connection_label,true,false,10);
        main_box.pack_start(connection_status,false,false,10);
        //
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.get_style_context ().add_class ("rounded");
        main_window.set_titlebar(hb);
        main_window.add(main_box);
        main_window.default_height = 400;
        main_window.default_width = 500;
        main_window.title = "Lroton";
        main_window.show_all ();
    }

    private void clearConnection(){
        string protonvpn_stdout = "";
        string protonvpn_stderr = "";
        int protonvpn_status = 0;
        Process.spawn_command_line_sync ("sudo protonvpn d",
        out protonvpn_stdout,
        out protonvpn_stderr,
        out protonvpn_status);
        status = false;
    }

    private void fastConnection(){
        string protonvpn_stdout = "";
        string protonvpn_stderr = "";
        int protonvpn_status = 0;
        if (status) {
            try {
                Process.spawn_command_line_sync ("sudo protonvpn d",
                out protonvpn_stdout,
                out protonvpn_stderr,
                out protonvpn_status);
                status = false;
                connect_btn.set_image(new Gtk.Image.from_gicon (new ThemedIcon ("network-vpn"),Gtk.IconSize.LARGE_TOOLBAR));
                connection_icon.gicon = new ThemedIcon ("emblem-unreadable");
                connection_label.set_text("Your Connection is Not Secure");
                connection_status.set_text("");    
            } catch (Error e) {
                stdout.printf(e.message);
            }
        }else{
            try {
                Process.spawn_command_line_sync ("sudo protonvpn c -f",
                out protonvpn_stdout,
                out protonvpn_stderr,
                out protonvpn_status);
                status = true;
                connect_btn.set_image(new Gtk.Image.from_gicon (new ThemedIcon ("process-stop"),Gtk.IconSize.LARGE_TOOLBAR));    
                connection_icon.gicon = new ThemedIcon ("emblem-readonly");
                connection_label.set_text("Your Connection is Secure");
                connection_status.set_text(protonvpn_stdout);   
            } catch (Error e) {
                stdout.printf(e.message);
            }
        }
    }


    public static int main (string[] args) {
        var app = new Application ();
        return app.run (args);
    }
}

