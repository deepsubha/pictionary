public without sharing class AccountSave {
	public Account account{get; set;}
	public AccountSave(){
		account = new Account();
	}
	
	public void save(){
		upsert account;
        account = null;
	}
}