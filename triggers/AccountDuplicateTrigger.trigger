trigger AccountDuplicateTrigger on Account (before insert, before update){
    Set<String> setName = new Set<String>();
  //  Set<String> setName = new Set<String>();
 for(Account a:Trigger.new){
    setName.add(a.Name);
 }
    String queryString = 'select Name  from Account where Name IN : setName' ;
    List<Account> accList = database.query(queryString);
    If(accList.size() > 0){
      for(Account acc : Trigger.new){
        acc.Name.addError('Duplicate');
    }
    }
 }