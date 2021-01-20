/**
 * 
 */
public class Dialogs.About : Gtk.AboutDialog {

	construct{
        program_name = "Lroton";
        logo_icon_name = "com.github.rajsolai.lroton";
        comments = "Proton Vpn Client for Freedesktop ! 🔒️";
        website = "http://en.wikipedia.org/wiki/Scrooge_McDuck";
        website_label = "Scrooge McDuck and Co.";
        version = "0.1";
        response.connect ((response_id) => {
            if (response_id == Gtk.ResponseType.CANCEL || response_id == Gtk.ResponseType.DELETE_EVENT) {
                this.hide_on_delete ();
            }
        });
        //this.run();
        //this.destroy();
        this.present();
	}

}