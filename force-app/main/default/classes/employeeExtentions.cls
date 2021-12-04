public class employeeExtentions {

    public string s{set;get;}
    public Employee__c g;
    public List<Employee__c> employeeList{get;set;}
    
    public employeeExtentions(ApexPages.StandardController gObj) {
        g = (Employee__c)gObj.getRecord();
        system.debug('😆');
    }
    public void foobar(){
    //SOQL
    employeeList=[SELECT Id,Name,   skill_set__c,Gadget__r.Name FROM Employee__c];
    }
    
}