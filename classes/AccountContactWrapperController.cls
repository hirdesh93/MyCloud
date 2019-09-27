public class AccountContactWrapperController { 

    public List<Account> accounts{get;set;}
    public List<ACWrapper> ACWrappers{get;set;}

    public AccountContactWrapperController(){
        this.ACWrappers = new List<ACWrapper>();
        this.accounts = new List<Account>();

        //Get Accounts & Related Contacts in 1 query
        List<Account> accs = [Select Id, Name, (Select Id, FirstName, LastName From Contacts) From Account];
        this.accounts = accs;

        //Get Accounts & Contacts in separate queries for Wrapper
        List<Account> accsForWrapper = [Select Id, Name From Account ];
        List<Contact> consForWrapper;
        Account acc;
        if(accsForWrapper != null && !accsForWrapper.isEmpty()){
            acc = accsForWrapper.get(0);
            consForWrapper = [Select Id, FirstName, LastName From Contact Where AccountId =:acc.Id];
        }
        if(consForWrapper != null){
            ACWrapper wrapper = new ACWrapper(acc, consForWrapper);
            this.ACWrappers.add(wrapper);
        }
    }

    public class ACWrapper{
        public Account account{get;set;}
        public List<Contact> contacts{get;set;}

        public ACWrapper(Account acc, List<Contact> cons){
            account = acc;
            contacts = cons;
        }
    }

}