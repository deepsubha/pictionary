public class CustomEmployeeClass {

    public List<Account> account{set;get;}

    
    public void foobar(){
        account=[select Name,Id,Rating,Industry from Account];    
    }
}