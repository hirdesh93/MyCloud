public class ActionFunEx {
    String username;
    public String getUsername() {
        return username;
    }

    private String TempVal = 'Hirdesh';
           
    public PageReference AFcall() {
        username = UserInfo.getName();
        return null;
    }
           
    public void setTempVal(String n) {
        TempVal = n;
    }
           
    public String getTempVal() {
        return TempVal;
    }
          
    public PageReference ActionMethod() {
        return null;
    }

}