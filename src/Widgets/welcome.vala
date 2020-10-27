/**
 * 
 */
public class Widgets.Welcome : Gtk.EventBox {

	Widgets.ConnectedBox connected_box;

	public Welcome() {
		var granite_welcome = new Granite.Widgets.Welcome ("Welcome to Lroton","Connect and secure your connection" );
		granite_welcome.append("network-vpn","Fast Connect","Connect to the Fastest VPN Server");
        granite_welcome.append("network-vpn","Random Connect","Connect to a Random VPN Server");

        granite_welcome.activated.connect((index)=>{
        	selected(index);
        });

        add(granite_welcome);
	}

	public signal void selected (int index);

	private void fast_connect(){

	}
	
}