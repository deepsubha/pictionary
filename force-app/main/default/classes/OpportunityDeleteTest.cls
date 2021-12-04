@isTest(SeeAllData=false)
public class OpportunityDeleteTest {
    static testMethod void testDeleteOpportunities(){
        List<Opportunity> opps= new List<Opportunity>();
        
        for(Integer i=0 ;i <10;i++)
        {
            Opportunity op = new Opportunity();
            op.Name = 'opportunity'+i;
            op.StageName = 'Closed Won';
            op.Testable__c = true;
            op.CloseDate = Date.newInstance(2017, 12, 12);
            opps.add(op);
        }
        for(Integer i=10 ;i <20;i++)
        {
            Opportunity op = new Opportunity();
            op.Name = 'opportunity'+i;
            op.StageName = 'Closed Lost';
            op.Testable__c = true;
            op.CloseDate = Date.newInstance(2017, 12, 12);
            opps.add(op);
        }
        for(Integer i=20 ;i <25;i++)
        {
            Opportunity op = new Opportunity();
            op.Name = 'opportunity'+i;
            op.StageName = 'Prospecting';
            op.Testable__c = true;
            op.CloseDate = Date.newInstance(2017, 12, 12);
            opps.add(op);
        }        
        insert opps;
        
        List<Opportunity> Bops=[select Id from Opportunity];
        Integer BallCount = Bops.size();
        System.debug(BallCount);
        System.assertEquals(25, BallCount);
        
        Test.startTest(); 
        OpportunityDelete b = new OpportunityDelete ('SELECT Id,Name,AccountId,StageName,Testable__c FROM Opportunity where Testable__c=true AND (StageName = \'Closed Lost\' OR StageName = \'Closed Won\')');
        database.executebatch(b,100);     
        Test.stopTest();
        
        List<Opportunity> Aops=[select Id from Opportunity];
        Integer AallCount = Aops.size();
        System.debug(AallCount);
        System.assertEquals(5, AallCount);
    }    
}