global with sharing class Myglobalclass {
    global static void myMethod(){
        AccountContact.sendMail('hirdeshgangil@gmail.com', 'Test', 'TestMessage');
    }
}