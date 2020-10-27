/**
 * 
 */
public class Widgets.ConnectedBox : Gtk.EventBox {

	public ConnectedBox(string status) {
		stdout.printf("Status in ConnectedBox is %s",status);
		var main_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        var connection_icon = new Gtk.Image ();
        connection_icon.gicon = new ThemedIcon ("emblem-readonly");
        connection_icon.pixel_size = 128;
        var connection_status = new Gtk.Label(status);
        var disconnect_btn = new Gtk.Button.with_label("Disconnect");
        disconnect_btn.clicked.connect(()=>{
        	disconnect_signal();
        });
        var connection_label = new Gtk.Label("Your Connection is Secure");
        connection_label.get_style_context().add_class("h2");
        main_box.pack_start(connection_icon,false,false,80);
        main_box.pack_start(connection_label,true,false,10);
        main_box.pack_start(connection_status,false,false,10);
        main_box.pack_start(disconnect_btn,true,true,10);
        add(main_box);
	}

	public signal void disconnect_signal();

	
}