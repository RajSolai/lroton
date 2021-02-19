/**
 *
 */
public class Widgets.ConfigBox : Gtk.Overlay {

    Services.Configuration configuration ;

    Granite.Widgets.Toast toast ;
    Granite.Widgets.Toast err_toast ;

    public ConfigBox () {

        var main_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 5) ;
        var input_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 5) ;
        var username_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 5) ;
        var password_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 5) ;
        var tier_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 5) ;
        var title_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 30) ;
        var button_box = new Gtk.ButtonBox (Gtk.Orientation.HORIZONTAL) ;
        toast = new Granite.Widgets.Toast ("Account Configured Successfully!") ;
        toast.set_default_action ("Okay") ;
        err_toast = new Granite.Widgets.Toast ("Please Fill all the details") ;


        var title_label = new Gtk.Label ("Configure OpenVPN profile") ;
        title_label.get_style_context ().add_class ("h2") ;
        var username_label = new Gtk.Label ("Enter OpenVPN Username") ;
        var password_label = new Gtk.Label ("Enter OpenVPN Password") ;
        var tier_label = new Gtk.Label ("Select your Account's ProtonVPN Plan") ;

        var username_entry = new Gtk.Entry () ;
        var password_entry = new Gtk.Entry () ;
        var tier_combobox = new Gtk.ComboBoxText () ;
        tier_combobox.append_text ("Free") ;
        tier_combobox.append_text ("Basic") ;
        tier_combobox.append_text ("Plus") ;
        tier_combobox.append_text ("Visionary") ;
        var login_button = new Gtk.Button.with_label ("Login") ;
        var back_button = new Gtk.Button.with_label ("Back") ;
        back_button.get_style_context ().add_class ("back_btn") ;
        username_entry.placeholder_text = "Collection of Alphabets A-Z,a-z" ;
        password_entry.placeholder_text = "Collection of Alphabets A-Z,a-z" ;

        login_button.clicked.connect (() => {
            var username = username_entry.get_text () ;
            var password = password_entry.get_text () ;
            var tier = tier_combobox.get_active_text () ;
            if( username != null && password != null && tier != null ){
                login (username, password, get_tier_id (tier)) ;
            } else {
                err_toast.send_notification () ;
            }
        }) ;

        back_button.clicked.connect (() => {
            back_to_welcome () ;
        }) ;

        toast.default_action.connect (() => {
            back_to_welcome () ;
        }) ;

        button_box.add (login_button) ;
        button_box.add (back_button) ;
        button_box.set_layout (Gtk.ButtonBoxStyle.CENTER) ;
        button_box.set_spacing (10) ;
        tier_box.pack_start (tier_label, true, true, 10) ;
        tier_box.pack_end (tier_combobox, true, true, 10) ;
        username_box.pack_start (username_label, true, true, 10) ;
        username_box.pack_start (username_entry, true, true, 10) ;
        password_box.pack_start (password_label, true, true, 10) ;
        password_box.pack_start (password_entry, true, true, 10) ;
        title_box.pack_start (title_label, true, true, 10) ;
        input_box.pack_start (username_box, false, false, 5) ;
        input_box.pack_start (password_box, false, false, 5) ;
        input_box.pack_start (tier_box, false, false, 5) ;
        main_box.pack_start (title_box, false, false, 40) ;
        main_box.pack_start (input_box, false, false, 10) ;
        main_box.pack_start (button_box, false, false, 20) ;

        add_overlay (main_box) ;
        add_overlay (toast) ;
        add_overlay (err_toast) ;
    }

    public signal void back_to_welcome() ;

    private void login(string username, string password, string tier) {
        configuration = new Services.Configuration (username, tier, password) ;
        toast.send_notification () ;
    }

    private string get_tier_id(string tier) {
        string tier_id = "0" ;
        if( tier == null ){
            tier_id = "0" ;
        } else {
            switch( tier ){
            case "Free":
                tier_id = "0" ;
                break ;
            case "Basic":
                tier_id = "1" ;
                break ;
            case "Plus":
                tier_id = "2" ;
                break ;
            case "Visionary":
                tier_id = "3" ;
                break ;
            default:
                tier_id = "0" ;
                break ;
            }
        }
        return tier_id ;
    }

}