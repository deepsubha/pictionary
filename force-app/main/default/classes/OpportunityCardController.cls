public with sharing class OpportunityCardController {
    public OpportunityCardController() {}
    @AuraEnabled(Cacheable=true)
    public static List<Opportunity> findByCloseDate(String closeDateValue) {
        
        List<Opportunity> allOpp= [SELECT id, Name, Amount,StageName,Type,CloseDate,Account.Name FROM Opportunity WHERE CloseDate = :Date.valueOf(closeDateValue)];
        system.debug(allOpp);
        return allOpp;
    }


    @AuraEnabled(Cacheable=true)
    public static String appendRecord(String OppId){
        system.debug('Opp Id to be sent:'+OppId);
        Opportunity opp = [select Id,Type,StageName,Name,Account.Name,CloseDate,Amount from Opportunity where id =:OppId];
		String returnBody;
		HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:GoogleSheetAPI/v4/spreadsheets/1GxZzfMssamM1bm7Sn0bfQhWn5MnlDyy_IQTl61U3URA/values/Sheet1:append?valueInputOption=RAW');
        req.setHeader('Accept', 'application/json');
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        String jsonString = '{'+
            '"majorDimension": "ROWS",'+
            '"values": ['+
            '["'+opp.Id+'","'+opp.Name+'","'+opp.Account.Name+'","'+opp.Type+'","'+opp.StageName+'","'+opp.Amount+'","'+opp.CloseDate+'"]'+
            
            ' ],'+
            '"range": "Sheet1"'+
            '}';
        system.debug('request body^^^^'+jsonString);
        req.setBody(jsonString);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug(res.getBody());
        if(res.getStatusCode() == 200){
            // Opportunity o = new Opportunity(Id = OppId);
            // o.GoogleSheet_Integration__c = true;
            // update o;
            returnBody = 'success';
        }
        else
            returnBody = 'failed';
        
        return returnBody;
    }

    @AuraEnabled
    public static String updateOpp(String opId){
        system.debug('in start'+opId);
        Opportunity o = new Opportunity(Id = opId);
        o.GoogleSheet_Integration__c = true;
        update o;
        system.debug('in end');
        return 'success';
    }

    @AuraEnabled(Cacheable=true)
    public static String appendRecords(List<String> OppIds){
        system.debug(OppIds);
        List<Opportunity> opps = [select Id,Type,StageName,Name,Account.Name,CloseDate,Amount from Opportunity where id IN:OppIds];
        String returnBody;
        system.debug(opps.size());
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:GoogleSheetAPI/v4/spreadsheets/1GxZzfMssamM1bm7Sn0bfQhWn5MnlDyy_IQTl61U3URA/values/Sheet1:append?valueInputOption=RAW');
        req.setHeader('Accept', 'application/json');
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        Http http = new Http();
        for(Integer i=0;i<opps.size();i++){
                
                String jsonString = '{'+
                    '"majorDimension": "ROWS",'+
                    '"values": ['+
                    '["'+opps[i].Id+'","'+opps[i].Name+'","'+opps[i].Account.Name+'","'+opps[i].Type+'","'+opps[i].StageName+'","'+opps[i].Amount+'","'+opps[i].CloseDate+'"]'+
                    
                    ' ],'+
                    '"range": "Sheet1"'+
                    '}';
                system.debug('request body^^^^'+jsonString);
                req.setBody(jsonString);
                
                HTTPResponse res = http.send(req);
                system.debug(res.getBody());
                if(res.getStatusCode() == 200)
                    returnBody = 'success';             
                else
                    returnBody = 'failed';
        }

        return returnBody;
    }
}