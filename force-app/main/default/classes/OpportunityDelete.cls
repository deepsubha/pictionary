//***********************This is the batch apex class to delete closed Opportunities named: OpportunityDelete*************************//



global class OpportunityDelete implements Schedulable,Database.Batchable<sObject>{
    private final string query;
    global OpportunityDelete(String q){
        this.query = q;
    }
    
    global void execute(SchedulableContext sc){
        OpportunityDelete b = new OpportunityDelete ('SELECT Id,Name,AccountId,StageName,Testable__c,RecordTypeId FROM Opportunity where CreatedDate = TODAY');
       
        database.executebatch(b,1);                 //with a batch size of 1
    }
    
	global Database.QueryLocator start(Database.BatchableContext BC)
    {
        system.debug('query ==>'+this.query);
        //String query = 'SELECT Id,Name,AccountId,StageName,Testable__c,RecordTypeId FROM Opportunity where Testable__c=true AND (StageName = \'Closed Lost\' OR StageName = \'Closed Won\')';
        return Database.getQueryLocator(this.query);
    }
 
    global void execute(Database.BatchableContext BC, List<Opportunity> scope)
    {
		system.debug(scope.size());
        for(Opportunity op:scope ){
            System.debug('Opp Id==>'+op.Id);
            System.debug('Opp Name==>'+op.Name);
            System.debug('Opp Account Id==>'+op.AccountId);
            System.debug('Opp Stage Name==>'+op.StageName);
            System.debug('Opp record type Id==>'+op.RecordTypeId);
        }
        system.debug(scope.size());
        
        //business logic
        List<Opportunity> toBeDeleted = new List<Opportunity>();
        for(Opportunity op:scope){
            if(op.RecordTypeId == '0122w000000HmkX' && (op.StageName == 'Closed Lost'||op.StageName == 'Closed Won' )){
                system.debug('record '+op.Id);
                toBeDeleted.add(op);
            }
        }
        if(toBeDeleted.size()>0){
            system.debug('total size '+toBeDeleted.size());
            delete toBeDeleted;
        }
        system.debug('total size '+toBeDeleted.size());
        
         
    }  
    global void finish(Database.BatchableContext BC)
    {
    }
}