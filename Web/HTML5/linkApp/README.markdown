# Link Application

Super bare bones basic app (not to mention the viewport settings are hacky) designed to just be able to save a web page to the iPhone - with say links instead of having to hunt for an email and such.

Be sure to share the `.manifest` file as `text/cache-manifest` or the offline caching won't work.

------

For those curious; the meta tags are for optimizing the web page on the phone but the bit that allows us to save the information is the line `<html manifest="cache-manifest.manifest">` along with what is defined in the `.manifest` file.