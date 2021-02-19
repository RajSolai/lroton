/**
 *
 */
public class Widgets.ApplicationHeader : Gtk.HeaderBar {

    Dialogs.About about ;
    /**
     *
     */

    public ApplicationHeader () {
        get_style_context ().add_class ("default-decoration") ;
        set_show_close_button (true) ;

        var about_btn = new Gtk.Button.with_label ("About") ;
        about_btn.clicked.connect (() => {
            about = new Dialogs.About () ;
        }) ;

        var menu_list = new Gtk.Grid () ;
        menu_list.add (about_btn) ;
        menu_list.show_all () ;

        var menu_popover = new Gtk.Popover (null) ;
        menu_popover.add (menu_list) ;

        var menu_button = new Gtk.MenuButton () ;
        menu_button.set_can_focus (false) ;
        menu_button.image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR) ;
        menu_button.popover = menu_popover ;

        pack_end (menu_button) ;

    }


}