public class TransientController {
    DateTime t1;
    transient DateTime t2; //declare
     
    public String getTime1() {
    if (t1 == null)
     t1 = System.now();
     system.debug(t1);
    return '' + t1;
        
    }
     
    public String getTime2() {
    if (t2 == null)
     t2 = System.now();
     
    return '' + t2;
    }
}