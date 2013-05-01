nme_download_file_example
=========================
This is a simple example of downloading a file in NME (Haxe)

It downloads a text file from an ASCII Art site, and saves it to a local file (Shared Object).
http://www.textfiles.com/art/LOGOS/paradise.txt

Since SharedObject is ported by NME to various platforms, this will save to a local file in Flash, Neko, and CPP targets.

Some error checking could possibly be added to this using an approach detailed here:
http://www.gigglingcorpse.com/2012/02/29/sharedobject-example-with-haxenme-for-flash-and-android/

or the file saving part (SharedObject) replaced with this approach detailed on the HaxeFlixel forums:
http://haxeflixel.com/forum/general-discussion/storing-game-state
