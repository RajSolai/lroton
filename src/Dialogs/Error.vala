/*
 * Copyright (c) 2020 - Today solairaj ()
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: solairaj <msraj085@gmail.com>
 */

public class Dialogs.Error : Gtk.Dialog {
    Gtk.Label error_title ;
    Gtk.Label error_message ;
    Gtk.LinkButton link_btn ;
    string error_link ;
    string error_link_text ;
    string error_message_text ;
    public Error (int code) {
        var box = this.get_content_area () ;
        this.set_default_size (350, 150) ;
        var error_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 8) ;
        if( code == 256 ){
            error_message_text = "Proton VPN not installed Please install by visiting" ;
            error_link_text = "https://protonvpn.com/support/linux-vpn-tool/" ;
            error_title = new Gtk.Label ("Proton VPN Missing") ;
            error_link = "Install Protonvpn" ;
            error_message = new Gtk.Label (error_message_text) ;
        } else if( code == 404 ){
            error_message_text = "Proton VPN Profile not configured" ;
            error_link_text = "https://github.com/RajSolai/lroton/issues" ;
            error_title = new Gtk.Label ("Configure Profile") ;
            error_link = "Cog/gear Icon in Welcome Page -> configure" ;
            error_message = new Gtk.Label (error_message_text) ;
        } else if( code == 32256 ){
            error_message_text = "Please allow the Permissons for VPN connect and disconnect services" ;
            error_link_text = "https://man7.org/linux/man-pages/man1/su.1.html" ;
            error_title = new Gtk.Label ("Permisson Denied") ;
            error_link = "Read more here" ;
            error_message = new Gtk.Label (error_message_text) ;
        } else {
            error_message_text = "Error Message Occured" ;
            error_link_text = "https://github.com/RajSolai/lroton/issues" ;
            error_title = new Gtk.Label ("Error") ;
            error_link = "Submit Issues" ;
            error_message = new Gtk.Label (error_message_text) ;
        }
        link_btn = new Gtk.LinkButton.with_label (error_link_text, error_link) ;
        error_message.set_line_wrap (true) ;
        error_message.set_size_request (300, -1) ;
        error_title.get_style_context ().add_class ("h2") ;
        error_title.get_style_context ().add_class ("h5") ;
        error_box.add (error_title) ;
        error_box.add (error_message) ;
        error_box.add (link_btn) ;
        box.add (error_box) ;
        this.show_all () ;
    }
}