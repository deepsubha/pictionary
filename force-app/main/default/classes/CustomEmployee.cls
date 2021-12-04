public class CustomEmployee {
    public List<Account> account{set;get;}
    public CustomEmployee(ApexPages.StandardController controller){
        
    }
    
    public void foobar(){
        account=[select Name,Id,Rating,Industry from Account];
    }
}