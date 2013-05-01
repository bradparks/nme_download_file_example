package;
 
import nme.events.IOErrorEvent;
import nme.Assets;
import nme.utils.Timer;
import nme.Lib;
import nme.events.TimerEvent;
import nme.events.Event;
import nme.net.URLLoader;
import nme.net.URLRequest;
import nme.errors.SecurityError;
import nme.display.Loader;
import nme.net.URLRequest;
import nme.net.URLLoaderDataFormat;
import nme.utils.ByteArray;
 
class DynamicFile 
{
  private var contents: String;
  public var urlToLoad: String;
  private var refreshTimer : Timer;
  public var onComplete:Dynamic = null;
 
  public function hasContent():Bool
  {
    return contents != null;
  }
 
  public function new(anUrl:String, ?interval:Null<Int>)
  {
    contents = null;
 
    if (interval != null)
    {
      refreshTimer = new Timer(interval);
      refreshTimer.addEventListener(TimerEvent.TIMER, onTimeChange);
      refreshTimer.start();
    }
 
    urlToLoad = anUrl;
 
    downloadFileAtUrl();
  }
 
 
  private function downloadFileAtUrl()
  {
    loadFile(urlToLoad);
  }
 
  private function onTimeChange(event : TimerEvent) : Void 
  {
    downloadFileAtUrl();
  }
 
  private function loadFile(anUrl:String)
  {
    try 
    {
      var request:URLRequest = new URLRequest(anUrl);
      var loader = new URLLoader();
 
      loader.dataFormat = URLLoaderDataFormat.BINARY;        
      loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
      //loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
      loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
      loader.load(request);
    }
    catch (unknown : Dynamic) 
    {
      trace("Unknown exception : "+Std.string(unknown));
    }
  }
 
  function errorHandler(event:IOErrorEvent)
  {
    trace("Couldnt download file... ERROR:" + urlToLoad);
  }
 
  private function loaderCompleteHandlerBytes(data:ByteArray):Void 
  {
    contents = data + '';

#if !flash
    data.writeFile("/tmp/file.txt");
#end
 
    loaderCompleteHandlerString(contents);
  }
 
  private function loaderCompleteHandlerString(data:String):Void 
  {
    contents = data;

    if (this.onComplete != null)
    {
      onComplete(data);
    }
  }
 
  private function loaderCompleteHandler(event:Event):Void 
  {
    var data:ByteArray = cast(event.target, URLLoader).data;
 
    loaderCompleteHandlerBytes(data);
  }
}
