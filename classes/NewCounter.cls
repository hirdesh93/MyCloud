public class NewCounter {
    public List<Integer> testList {get; set;}
    public integer splitValue {get; set;}
    
    public NewCounter(){
        testList = new List<Integer>();
        splitValue =0;
    }

    public void counter(){
        testList.clear();
        integer j = 0;
        integer k = 1;
        integer c = 0;
        testList.add(j);
        testList.add(k);
        
        for(integer i=0;i<=splitValue-2;i++){
            c = j+k;
            j = k;
            k = c;
            testList.add(c);
        }
    }
    
}