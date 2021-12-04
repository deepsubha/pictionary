import { LightningElement, track } from 'lwc';
import findAccount from '@salesforce/apex/AccountController.findAccount';
const delay=350;
export default class SearchPage extends LightningElement {
    @track accounts;
    @track error;

    handleKeyChange(event){
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(()=>{
            findAccount({searchKey})
            .then(results => {
                this.accounts = results;
                console.log(this.accounts.id);
                this.error = undefined;
            })
            .catch(error=>{
                this.error = error;
                this.accounts = undefined;
            });
        },
        delay);
    }

}