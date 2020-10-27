/**
 * 
 */
public class Dialogs.About : Gtk.MessageDialog {

	construct{
		var icon = new Gtk.Image ();
		icon.gicon = new ThemedIcon ("com.github.rajsolai.lroton");
		icon.pixel_size = 24;
        this.message_type=Gtk.MessageType.INFO;
        this.buttons=Gtk.ButtonsType.OK;
        this.text="Lroton";
        this.format_secondary_text(
            "A Simple & Minimal Wrapper for ProtonVPN"
        );
        this.set_image(icon);
        this.run();
        this.destroy();
	}

}