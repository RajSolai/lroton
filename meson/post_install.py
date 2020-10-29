#!/usr/bin/env python3
import os
from os import path, environ, system
import subprocess

prefix = environ.get('MESON_INSTALL_PREFIX', '/usr/local')
schemadir = path.join(environ['MESON_INSTALL_PREFIX'], 'share', 'glib-2.0', 'schemas')
datadir = path.join(prefix, 'share')
desktop_database_dir = path.join(datadir, 'applications')

def install_protonvpn():
	system('sudo apt install -y openvpn dialog python3-pip python3-setuptools')
	system('python3 -m pip install protonvpn-cli')

# install protonvpn
if system('which protonvpn') != 0:	
	install_protonvpn()


if not environ.get('DESTDIR'):
    print('Compiling gsettings schemas…')
    subprocess.call(['glib-compile-schemas', schemadir])
    print('Updating desktop database…')
    subprocess.call(['update-desktop-database', '-q', desktop_database_dir])
    print('Updating icon cache…')
    subprocess.call(['gtk-update-icon-cache', '-qtf', path.join(datadir, 'icons', 'hicolor')])
