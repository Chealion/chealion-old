=== Plugin Name ===
Contributors: mcjones
Donate link: N/A
Tags: comments, spam
Requires at least: 2.6.2
Tested up to: 2.6.2
Stable tag: 1.0

Adds a simple field required to be filled out for when submitting a comment. Just asks for the present 4-digit year.

== Description ==

Adds a simple field required to be filled out for when submitting a comment. Just asks for the present 4-digit year. If a spam attack is targeted at the specific site it'll do nothing but more likely the information will be bogus.

== Installation ==

This section describes how to install the plugin and get it working.

e.g.

1. Upload `plugin-name.php` to the `/wp-content/plugins/` directory
1. Activate the plugin through the 'Plugins' menu in WordPress
1. Place `<?php do_action('plugin_name_hook'); ?>` in your templates

== Frequently Asked Questions ==

= Can you change what is being asked for? =

No. Not yet.

= What is your roadmap? =

The first version will only support the year, just show and that's it.

1.1 will auto fill and hide itself for commentors returning or registered users

2.0 will allow you to change what it asks for; defaults are year, month, or a short word of your choice. In the end it's a SUPER basic and SUPER user friendly captcha and is intended to be nothing more.