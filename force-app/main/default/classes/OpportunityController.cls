public with sharing class OpportunityController {
    public OpportunityController() {}

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunity(String searchKey,String filterKey){
        system.debug('filterKey: '+filterKey+'searchKey: '+searchKey);
        List<Opportunity> allOpportunities = new List<Opportunity>();

        if(filterKey=='' || filterKey=='CloseDate'){
            try{
                Decimal amount=Decimal.valueOf(searchKey);
                allOpportunities=[select Id,Name,Account.Id,Account.Name,StageName,Type,Amount from Opportunity where Amount =: amount ];
                if(allOpportunities.size() == 0){
                    throw new AuraHandledException('No Record Found..'); 
                }           
            }catch(Exception e){
                String key='%'+searchKey+'%';          
                allOpportunities=[select Id,Name,Account.Id,Account.Name,StageName,Type,Amount from Opportunity where Name Like:key OR Account.Name LIKE :key OR StageName LIKE :key OR Type LIKE :key ];
                if(allOpportunities.size() == 0){
                    throw new AuraHandledException('No Record Found..'); 
                }       	
            }  
        }else if(filterKey=='Amount'){
            Decimal amount=Decimal.valueOf(searchKey);
            allOpportunities=[select Id,Name,Account.Id,Account.Name,StageName,Type,Amount from Opportunity where Amount =: amount ];
            if(allOpportunities.size() == 0){
                throw new AuraHandledException('No Record Found..'); 
            } 
        }else{
            String key='%'+searchKey+'%'; 
            String query = 'select Id,Name,Account.Id,Account.Name,StageName,Type,Amount from Opportunity where '+filterKey+' Like:key'; 
            allOpportunities = Database.query(query);
            
            //allOpportunities=[select Id,Name,Account.Id,Account.Name,StageName,Type,Amount from Opportunity where :filterKey Like:key ];
            if(allOpportunities.size() == 0){
                throw new AuraHandledException('No Record Found..'); 
            } 
        }
        
        return allOpportunities;
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> opportunityDetails(String searchHints){
        String key=searchHints+'%';
        List<Opportunity> allDetails = [SELECT Name from Opportunity where Name Like:key limit 4];
        return allDetails;
    }

}