package;

class EzUtils 
{
  static public function isDefined(obj)
  {
    return ! isMissing(obj);
  }

  static public function isMissing(obj)
  {
    if (obj == null)
      return true;

    var aStr = obj + "";

    if (StringTools.trim(aStr) == "")
      return true;
    
    return false;
  }

  // Recursively delete everything reachable from the path. 
  // Silently ignores nonexisting paths. 
  public static function unlink( path : String ) : Void 
  { 
#if !flash
    if (sys.FileSystem.exists(path) ) 
    { 
      if (sys.FileSystem.isDirectory(path) ) 
      { 
        for (entry in sys.FileSystem.readDirectory(path) ) 
        { 
          unlink (path + "/" + entry ); 
        } 
        sys.FileSystem.deleteDirectory(path); 
      } 
      else 
      { 
        sys.FileSystem.deleteFile(path); 
      } 
    } 
#end
  } 

  static public function replace(subject, searchFor, replaceWith)
  {
    return StringTools.replace(subject, searchFor, replaceWith);
  }

  static public function fullPath(folder:String, filename:String)
  {
    return folder + "/" + filename;
  }

  static public function ensureFoldersExist(filename:String)
  {
#if !flash
      if (sys.FileSystem.exists(filename))
      {
        return;
      }

      var folders = filename.split("/");
      var currPath = "/";

      for (i in 0...folders.length-1)
      {
        var folder = folders[i];
        if (isMissing(folder))
          continue;

        currPath += folder + "/";

        if (sys.FileSystem.exists(currPath))
          continue;

        //trace("create folder:" + currPath);
        sys.FileSystem.createDirectory(currPath);
      }
#end
  }

  static public function getUid():Float
  {
    return Date.now().getTime();
  }
}
