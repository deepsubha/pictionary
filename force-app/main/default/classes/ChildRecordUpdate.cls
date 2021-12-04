public class ChildRecordUpdate {

    public void childUpdate(String rid){
        List<Opportunity> opp = new List<Opportunity>();
        List<Account> childUpdate = [select id,name,website,(select id,name,TrackingNumber__c from opportunities)from Account where id=:rid];
        for(Account a:childUpdate){
            system.debug('account Id: '+a.Id);
            system.debug('account name: '+a.Name);
            system.debug('website name: '+a.website);
            a.website = 'mnopfghjj';
            
            for(opportunity o:a.opportunities){
                system.debug('opportunity id: '+o.Id);
                system.debug('opportunity name: '+o.name);
                system.debug('opportunity amount: '+o.TrackingNumber__c);
                o.TrackingNumber__c='aaaaaaaaaaaaaaaaaa';
                opp.add(o);
            }
            
        }
        update opp;
        //update childUpdate.opportunity;
    }
}