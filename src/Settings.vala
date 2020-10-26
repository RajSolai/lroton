/**
 * 
 */
public class Settings : Gtk.Dialog {

	public Settings() {
		this.title = "Sample";
	}

	construct{
		var box = this.get_content_area();
		this.set_default_size(250, 150);
		var inputbox = new Gtk.Box(Gtk.Orientation.VERTICAL,5);
		var uid_label = new Gtk.Label("Enter Uid");
		var password_label = new Gtk.Label("Enter Password");
		var uid_text_view = new Gtk.TextView();
		var password_text_view = new Gtk.TextView();
		inputbox.pack_start(uid_label);
		inputbox.pack_start(uid_text_view);
		inputbox.pack_start(password_label);
		inputbox.pack_start(password_text_view);
		box.add(inputbox);
		this.show_all();
	}

}