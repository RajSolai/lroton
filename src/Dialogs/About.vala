/**
 * 
 */
public class Dialogs.About : Gtk.AboutDialog {

	construct{
        program_name = "Lroton";
        logo_icon_name = "com.github.rajsolai.lroton";
        comments = "Proton Vpn Client for Freedesktop ! 🔒️";
        website = "https://rajsolai.github.io/lroton/";
        website_label = "Visit Lroton";
        version = "0.1";
        response.connect ((response_id) => {
            if (response_id == Gtk.ResponseType.CANCEL || response_id == Gtk.ResponseType.DELETE_EVENT) {
                this.hide_on_delete ();
            }
        });
        this.present();
	}

}