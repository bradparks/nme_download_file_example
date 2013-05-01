import nme.display.Sprite;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.Assets;
import nme.net.SharedObject;


class Main extends Sprite 
{
  public var fileDownloader:DynamicFile;
  public var state:SharedObject;

	public function new () 
  {
		
		super ();
		
    fileDownloader = new DynamicFile("http://www.textfiles.com/art/LOGOS/paradise.txt");
    fileDownloader.onComplete = onDownloadComplete;

    state = SharedObject.getLocal("mydata"); 

    loadText("Please wait.... Downloading text", 50);
  }

	public function onDownloadComplete(downloadedFileAsText:String) 
  {
    loadText("Downloaded and saved the following:", 100);
    loadText(downloadedFileAsText, 150);

    // Save the downloaded file on the users system using a shared object.
    state.data.savedFile = downloadedFileAsText;
    state.flush();

    //trace(downloadedFileAsText);
  }

	public function loadText (someText:String, y:Int) {
    if (someText == null)
      someText = "No text downloaded yet. Please run again.";

		var format = new TextFormat (Assets.getFont ("assets/KatamotzIkasi.ttf").fontName, 25, 0x7A0026);
		var textField = new TextField ();
		
		textField.defaultTextFormat = format;
		textField.embedFonts = true;
		textField.selectable = false;
		
		textField.x = 50;
		textField.y = y;
		textField.width = 600;
		
		textField.text = someText;
		
		addChild (textField);
	}
}
