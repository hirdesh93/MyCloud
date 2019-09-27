public with sharing class apextojavascript {
    public string calltoclose {get;set;}
    public void close(){
        calltoclose = '<script> closeWin(); </script>';
    }
}