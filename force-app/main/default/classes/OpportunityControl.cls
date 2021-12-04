//***********************This is the batch apex class to delete closed Opportunities named: OpportunityDelete*************************//


global class OpportunityControl implements Schedulable,Database.Batchable<sObject>{
global string query ;
    global OpportunityControl(){       
        //String q = System.Label.ClosedOpportunity;
        //this.query = q; 
    }
    global OpportunityControl(String q){  //2nd cons
        this.query = q;
    }
    //global OpportunityControl(String q, String recordTypeId){                               //not requ
     //   String finalQuery = q+' AND RecordTypeId = \''+recordTypeId+'\'';
     //   system.debug('final query -->'+finalQuery);
     //   this.query = finalQuery;
    //}
    global OpportunityControl(List<String> recordTypeNames){                              //remove string q, pass only rIds
            																			  //AND RecordTypeId IN :'abc1','abc2'
        system.debug(recordTypeNames);
        system.debug('by default query -->'+this.query);
        this.query = this.query + ' AND RecordType.Name IN :recordTypeNames';
        system.debug(this.query);
    }
    
    global void execute(SchedulableContext sc){
        OpportunityDelete b = new OpportunityDelete ('SELECT Id,Name,AccountId,StageName,Testable__c,RecordTypeId FROM Opportunity where CreatedDate = TODAY');
       
        database.executebatch(b,1);                 //with a batch size of 1
    }
    
	global Database.QueryLocator start(Database.BatchableContext BC)
    {
        system.debug('query in start==>'+this.query);
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
        Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('quick record types').getRecordTypeId();
        List<Opportunity> toBeDeleted = new List<Opportunity>();                     //pick the rId from schema 
        for(Opportunity op:scope){
            //List<string> oppStageName = op.StageName.Split(' ');
            if(op.RecordTypeId == devRecordTypeId){        //record type == quick records type
                system.debug('record '+op.Id);
                toBeDeleted.add(op);
            }
            else if(op.RecordTypeId != devRecordTypeId && op.StageName.contains('Closed')){     //other than quick records type
                system.debug('record '+op.Id);
                toBeDeleted.add(op);
            }
        }
        
        
        
        if(toBeDeleted.size()>0){
            system.debug('total size '+toBeDeleted.size());
            //delete toBeDeleted;
        }
        system.debug('total size '+toBeDeleted.size());
        
         
    }  
    global void finish(Database.BatchableContext BC)
    {
    }
}

/*			Annonymous window!!
 * //case 1:  only query
//OpportunityControl b = new OpportunityControl ('SELECT Id,Name,AccountId,StageName,Testable__c,RecordTypeId FROM Opportunity where CreatedDate = TODAY ');

//case 2:  query with recordtype id
//OpportunityControl b = new OpportunityControl ('SELECT Id,Name,AccountId,StageName,Testable__c,RecordTypeId FROM Opportunity where CreatedDate = TODAY' , '0122w000000HmkX');

//case 3:  query with multiple record type ids
Set<String> rIds = new Set<String>{'0122w000000HmkX','0122w000000HpRT'};
OpportunityControl b = new OpportunityControl ('SELECT Id,Name,AccountId,StageName,Testable__c,RecordTypeId FROM Opportunity where CreatedDate = TODAY' , rIds);

//database.executebatch(b,100); //SELECT Id,Name,AccountId,StageName,Testable__c,RecordTypeId FROM Opportunity where Testable__c=true AND CreatedDate = TODAY
//Set<String> rIds = new Set<String>{'0122w000000HmkX','0122w000000HpRT'};
//String joinedString = String.join(new List<String>(rIds), ',');
//system.debug('joinedString=='+joinedString);

OpportunityControl b = new OpportunityControl();
database.executebatch(b,1);

List<string> rName = new List<string>{'quick record types','my record type one'};
OpportunityControl b = new OpportunityControl(rName);
database.executebatch(b,1);

Integer i=0;
List<string> rName = new List<string>{'quick record types','my record type one'};
List<Opportunity> opps = [SELECT Id,Name,AccountId,StageName,Testable__c,RecordTypeId FROM Opportunity where CreatedDate = TODAY AND RecordType.Name IN :rName];
for(Opportunity op:opps){
    i=i+1;
    system.debug(i+'th opps');
    system.debug(op.name);
}

List<string> rName = new List<string>{'quick record types','my record type one'};
String q='SELECT Id,Name,AccountId,StageName,Testable__c,RecordTypeId FROM Opportunity where CreatedDate = TODAY  AND RecordType.Name IN :(';
for(String s:rName){
   q=q+'\''+s+'\',';
}
q=q.removeEnd(',');
q=q+')';
system.debug(q);

 

*/