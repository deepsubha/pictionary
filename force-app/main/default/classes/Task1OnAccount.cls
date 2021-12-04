public class Task1OnAccount {
 
      public List<Account> allAccounts{set;get;}
      List<Account> acc;
     public Task1OnAccount(ApexPages.StandardController controller){
                 acc=[select Name,Id,(select Id,FirstName,LastName from Contacts) from Account limit 6];
        //List<List<Contact>> con=acc.Contacts;
        for(Account all:acc){
            system.debug('🚀 account name'+all.Name);
            system.debug('🚀 account '+all.Id);
            for(Contact c:all.Contacts){
                system.debug('👍 contact id '+c.Id);
                system.debug('👍 contact first name '+c.FirstName);
                system.debug('👍 contact last name '+c.LastName);
            }
        }
        
     }//----------------------------------------------constructor ends----------------------------------------------
    
    public void foobar(){
       allAccounts=[select Name,Id,(select Id,FirstName,LastName from Contacts) from Account limit 6];
    }
}