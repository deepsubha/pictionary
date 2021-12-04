public class gadgetExtentions {

    //public String greet{set;get;}
    public Double s{set;get;}
    public gadget__c g;
    
    public gadgetExtentions(ApexPages.StandardController gObj) {
        g = (gadget__c)gObj.getRecord();
        
    }
    
    public void foobar(){
      
    
    }

}