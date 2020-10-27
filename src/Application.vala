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
    Gtk.Stack main_stack;
    Services.Protonvpn protonvpn = new Services.Protonvpn();
    Dialogs.Settings settings;
    Dialogs.About about;
    Dialogs.Error errorDialog;
    Widgets.Welcome welcome;
    Widgets.ConnectedBox connection;
    bool status;
    string vpn_status = "";


    public Application () {
        Object (
            application_id: "com.github.rajsolai.lroton",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        // stylesheet
        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/com/github/rajsolai/lroton/stylesheet.css");
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        
        var config_btn = new Gtk.Button.with_label("Configure");
        config_btn.clicked.connect (()=>{
            settings = new Dialogs.Settings();
        });

        var about_btn = new Gtk.Button.with_label("About");
        about_btn.clicked.connect (()=>{
            about = new Dialogs.About();
        });

        var menu_list = new Gtk.Grid();
        menu_list.add(config_btn);
        menu_list.attach_next_to(about_btn,config_btn,Gtk.PositionType.BOTTOM,1,1);
        menu_list.show_all();

        var menu_popover = new Gtk.Popover(null);
        menu_popover.add(menu_list);

        var menu_button = new Gtk.MenuButton ();
        menu_button.set_can_focus (false);
        menu_button.image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        menu_button.popover = menu_popover;        
        

        var hb = new Gtk.HeaderBar();
        hb.get_style_context ().add_class ("default-decoration");
        hb.set_show_close_button(true);
        hb.pack_end(menu_button);
        

        welcome = new Widgets.Welcome();
        connection = new Widgets.ConnectedBox(vpn_status);
        main_stack = new Gtk.Stack();
        main_stack.expand = true;
        main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
        main_stack.add_named (welcome, "welcome_view");
        main_stack.add_named (connection, "connection_view");

        welcome.selected.connect((index)=>{
            switch (index) {
                case 0:
                    fastConnection();
                    break;
                case 1:
                    randomConnection();
                    break;
                default:
                    stdout.printf("");
                    break;
            }
        });

        connection.disconnect_signal.connect(()=>{
            protonvpn.disconnect_server();
            main_stack.visible_child_name = "welcome_view";
        });

        var main_window = new Gtk.ApplicationWindow (this);
        main_window.get_style_context ();
        main_window.set_titlebar(hb);
        main_window.add(main_stack);
        main_window.default_height = 400;
        main_window.default_width = 500;
        main_window.title = "Lroton";
        main_window.show_all ();
    }

    private void fastConnection(){
        try {
                if(protonvpn.connect_fast_server()){
                    vpn_status = protonvpn.protonvpn_stdout;
                    main_stack.visible_child_name = "connection_view";
                    stdout.printf(protonvpn.protonvpn_stdout);
                    stdout.printf("%d",protonvpn.protonvpn_status);
                }else{
                    if (protonvpn.protonvpn_status == 256 && protonvpn.protonvpn_stdout != ""){
                        errorDialog = new Dialogs.Error(404);    
                    }else{
                        stdout.printf("the err is %s",protonvpn.protonvpn_stderr);
                        stdout.printf("the err code is %d",protonvpn.protonvpn_status);
                        switch (protonvpn.protonvpn_status) {
                            case 32256:
                                errorDialog = new Dialogs.Error(32256);
                                break;
                            case 256:
                                errorDialog = new Dialogs.Error(256);
                                break;
                            default:
                                stdout.printf("vanakkam");
                                break;
                        }
                    }
                }   
            } catch (Error e) {
                stdout.printf(e.message);
            }
    }

     private void randomConnection(){
        try {
                if(protonvpn.connect_random_server()){
                    main_stack.visible_child_name = "connection_view";
                    stdout.printf(protonvpn.protonvpn_stdout);
                    stdout.printf("%d",protonvpn.protonvpn_status);
                }else{
                    if (protonvpn.protonvpn_status == 256 && protonvpn.protonvpn_stdout != ""){
                        errorDialog = new Dialogs.Error(404);    
                    }else{
                        stdout.printf("the err is %s",protonvpn.protonvpn_stderr);
                        stdout.printf("the err code is %d",protonvpn.protonvpn_status);
                        switch (protonvpn.protonvpn_status) {
                            case 32256:
                                errorDialog = new Dialogs.Error(32256);
                                break;
                            case 256:
                                errorDialog = new Dialogs.Error(256);
                                break;
                            default:
                                stdout.printf("vanakkam");
                                break;
                        }
                    }
                }   
            } catch (Error e) {
                stdout.printf(e.message);
            }
    }

    public static int main (string[] args) {
        var app = new Application ();
        return app.run (args);
    }
}

