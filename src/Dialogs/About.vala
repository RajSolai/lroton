/**
 * 
 */
public class Dialogs.About : Gtk.Dialog {

	public About() {}

	construct{
		string about_message_text = "Lroton is a free to use ,Simple ,Minimal ,Proton VPN for Client for Elementary OS. The Dev I am a beginner to the Vala enivronment so please don't curse me! 😅️";
		var box = this.get_content_area();
		this.set_default_size(350, 150);
		var about_box = new Gtk.Box(Gtk.Orientation.VERTICAL,8);
		var about_title = new Gtk.Label("Lroton");
		var about_message = new Gtk.Label(about_message_text);
		about_message.set_line_wrap(true);
		about_message.set_size_request(300, -1);
		about_title.get_style_context().add_class("h2");
		about_title.get_style_context().add_class("h5");
		about_box.add(about_title);
		about_box.add(about_message);
		box.add(about_box);
		this.show_all();
	}

}