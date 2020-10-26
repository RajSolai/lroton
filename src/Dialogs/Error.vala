/**
 * 
 */
public class Dialogs.Error : Gtk.Dialog {
	Gtk.Label error_title;
	Gtk.Label error_message;
	Gtk.LinkButton link_btn;
	string error_link;
	string error_link_text;
	string error_message_text;
	public Error(int code) {
		var box = this.get_content_area();
		this.set_default_size(350, 150);
		var error_box = new Gtk.Box(Gtk.Orientation.VERTICAL,8);
		if (code == 256) {
			error_message_text = "Proton VPN not installed Please install by visiting";
			error_link_text = "https://protonvpn.com/support/linux-vpn-tool/";
			error_title = new Gtk.Label("Proton VPN Missing");
			error_link = "Install Protonvpn";
			error_message = new Gtk.Label(error_message_text);	
		}else{
			error_message_text = "Error Message Occured";
			error_link_text = "https://github.com/RajSolai/lroton/issues";
			error_title = new Gtk.Label("Error");
			error_link = "Submit Issues";
			error_message = new Gtk.Label(error_message_text);
		}
		link_btn = new Gtk.LinkButton.with_label(error_link_text,error_link);
		error_message.set_line_wrap(true);
		error_message.set_size_request(300, -1);
		error_title.get_style_context().add_class("h2");
		error_title.get_style_context().add_class("h5");
		error_box.add(error_title);
		error_box.add(error_message);
		error_box.add(link_btn);
		box.add(error_box);
		this.show_all();
	}
}