/**
 * 
 */
public class Widgets.Welcome : Gtk.EventBox {

	public Welcome() {
		var granite_welcome = new Granite.Widgets.Welcome ("Welcome to Lroton","Connect and secure your connection" );
		granite_welcome.append("lroton-fast-connect","Fast Connect","Connect to the Fastest VPN Server");
        granite_welcome.append("lroton-random-connect","Random Connect","Connect to a Random VPN Server");
        granite_welcome.append("preferences-system","Configure","Login to your Proton VPN account");
        granite_welcome.append("help-contents","Why app looks like frozen ?","Kindly Wait until Connection Establishment");
        granite_welcome.activated.connect((index)=>{
        	selected(index);
        });

        add(granite_welcome);
	}

	public signal void selected (int index);

}