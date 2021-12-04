public with sharing class OpportunityChartController {
    public OpportunityChartController() {}
    @AuraEnabled(cacheable=true)
    public static List<AggregateResult> getOpportunities(){
        return [SELECT SUM(ExpectedRevenue) expectRevenue, SUM(Amount) amount, StageName stage
               FROM Opportunity WHERE StageName NOT IN ('Closed Won') GROUP BY StageName LIMIT 20];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunitiesInfo(String filterData){
        System.debug(filterData);
        String query = 'SELECT Name, ExpectedRevenue, Amount, StageName FROM Opportunity WHERE '+filterData+' = true LIMIT 20';
        
        List<Opportunity> allOppsForChart = Database.query(query);
        system.debug(allOppsForChart);
        // return [SELECT Name, ExpectedRevenue, Amount, StageName
        //        FROM Opportunity where Mail_Sent__c = True LIMIT 20];
        return allOppsForChart;
    }
}