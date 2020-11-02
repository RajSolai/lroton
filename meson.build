# Project name, programming language and version
project (
    'com.github.rajsolai.lroton',
    'vala', 'c',
    version: '0.1.0'
)

# Translation module
gnome = import('gnome')
i18n = import ('i18n')

# Project arguments
add_project_arguments (
    '-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name ()),
    language: 'c'
)

# Listing dependencies
dependencies = [
    dependency ('glib-2.0'),
    dependency ('gtk+-3.0'),
    dependency ('granite'),
]

subdir ('src')

# Resources
as_resources = gnome.compile_resources (
    'as-resources', 'data/' + meson.project_name() + '.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

# Executable
executable (
    meson.project_name (),
    as_resources,
    sources,
    dependencies: dependencies,
    install: true
)

subdir ('data')
subdir ('po')

meson.add_install_script ('meson/post_install.py')
