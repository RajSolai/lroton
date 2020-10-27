/**
 * 
 */
public class Widgets.Welcome : Gtk.EventBox {

	public Welcome() {
		var granite_welcome = new Granite.Widgets.Welcome ("Welcome to Lroton","Connect and secure your connection" );
		granite_welcome.append("lroton-fast-connect","Fast Connect","Connect to the Fastest VPN Server");
        granite_welcome.append("lroton-random-connect","Random Connect","Connect to a Random VPN Server");

        granite_welcome.activated.connect((index)=>{
        	selected(index);
        });

        add(granite_welcome);
	}

	public signal void selected (int index);

}