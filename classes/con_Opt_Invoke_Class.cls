public class con_Opt_Invoke_Class{

@future(callout= true)
public static void Con_Opt_Invoke_Ins_Mtd(Id d){
    opportunity optrec=[select name,description,account.name from opportunity where id=:d]; 
     hirdeshNew2.Soap obj1=new  hirdeshNew2.Soap();
     hirdeshNew2.LoginResult lr=obj1.login('indreshgangwar23@gmail.com','wap5wap9');
     HirdeshTesting.Pub_oppertunitesCls obj=new HirdeshTesting.Pub_oppertunitesCls();
     
     obj.sessionHeader=new HirdeshTesting.sessionHeader_element();
     obj.sessionHeader.sessionid=lr.sessionid;
     obj.Pub_Insertopt(optrec.name,optrec.description,'0017F0000113UdI');
     }
   }