/**
 * 
 */
public class Dialogs.About : Gtk.MessageDialog {

	construct{
		var icon = new Gtk.Image ();
        this.message_type=Gtk.MessageType.INFO;
        this.buttons=Gtk.ButtonsType.OK;
        this.text="Welcome to Lroton Application";
        this.format_secondary_text(
            "A Simple & Minimal Wrapper for ProtonVPN for Elementary os, Made with Vala+❤️ by github.com/RajSolai"
        );
        this.run();
        this.destroy();
	}

}