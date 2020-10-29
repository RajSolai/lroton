/**
 * 
 */
public class Widgets.ConnectedBox : Gtk.EventBox {

	public ConnectedBox() {
                
        var main_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

        var connection_icon = new Gtk.Image ();
        connection_icon.gicon = new ThemedIcon ("emblem-readonly");
        connection_icon.pixel_size = 128;

        var disconnect_btn = new Gtk.Button.with_label("Disconnect");
		disconnect_btn.get_style_context ().add_class ("disconnect_btn");
        disconnect_btn.clicked.connect(()=>{
        	disconnect_signal();
        });

        var button_box = new Gtk.ButtonBox(Gtk.Orientation.VERTICAL);
        button_box.set_layout(Gtk.ButtonBoxStyle.START);
        button_box.set_spacing(5);
	button_box.add(disconnect_btn);

        var connection_label = new Gtk.Label("Your Connection is Secure");
        connection_label.get_style_context().add_class("h2");

        main_box.pack_start(connection_icon,false,false,80);
        main_box.pack_start(connection_label,true,false,10);
        main_box.pack_start(button_box,false,false,10);

        add(main_box);
	}

	public signal void disconnect_signal();

	
}