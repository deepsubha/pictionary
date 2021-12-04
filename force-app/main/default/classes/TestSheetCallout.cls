public class TestSheetCallout {
    @AuraEnabled( cacheable = true )
    public static String appendRecord(String OppId){
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
        if(res.getStatusCode() == 200)
            returnBody = 'success';
        else
            returnBody = 'failed';
        
        return returnBody;
    }
}
//POST https://sheets.googleapis.com/v4/spreadsheets/1GxZzfMssamM1bm7Sn0bfQhWn5MnlDyy_IQTl61U3URA/values/Sheet1:append?valueInputOption=RAW&key=[YOUR_API_KEY] HTTP/1.1

//Authorization: Bearer [YOUR_ACCESS_TOKEN]
//Accept: application/json
//Content-Type: application/json