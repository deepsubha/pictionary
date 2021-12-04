trigger accountTrigger on Account (after insert) {

    Map<String,Account> account=new Map<String,Account>();
    if(Trigger.isBefore && Trigger.isInsert){
    List<Account> acc=[select Name,Id,Industry,Rating,Type from Account where Id IN: Trigger.New];
    for(Account a:acc){
        account.put(a.Id,a);
    }
    }
}