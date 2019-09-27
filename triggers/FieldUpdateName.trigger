trigger FieldUpdateName on Program__c (Before insert) {
    
    
    
    // List<Program__c> prgList = [select id, name from Program__c];
    Map<Id,String> prgMap = new Map<Id,String>();
    for(Program__c prg : trigger.new){
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        String randStr = '';
        Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
        randStr += chars.substring(idx, idx+1);
        system.debug('testrandom:--'+ randStr);
        prg.Name = prg.Name +' '+ randStr;
        system.debug('testName'+ prg.Name);
        system.debug('testNamerandom'+ randStr);
        
    }
}