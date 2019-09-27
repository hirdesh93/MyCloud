public class LogoClass {
    public string ImgUrl {get;set;}
    public string Url {get;set;}
    public LogoClass(){
         Url = '';       
    }
    public void showLogo(){
      //  if(url.contains('www'))
      //  ImgUrl = Url.substring(Url.indexOf('.')+1,Url.length());
      //  else
        ImgUrl = Url;
    }
}