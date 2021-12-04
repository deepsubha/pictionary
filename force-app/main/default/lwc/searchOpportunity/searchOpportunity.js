import { LightningElement,track,api } from 'lwc';
import getOpportunity from '@salesforce/apex/OpportunityController.getOpportunity';
import opportunityDetails from '@salesforce/apex/OpportunityController.opportunityDetails';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'

export default class SearchOpportunity extends LightningElement {
    @track totalRecountCount = 0; 
    @api totalPage = 0; 
    @api pageSize = 5; 
    @track allOpps;
    @api OpportunityRecord;
    @api firstChunk;
    @api disablenextbutton ;
    @api disablepreviousbutton ;
    @track isminimized=true;
    @track isCloseDate = false;
    @track showSpinner=false;
    @track spinnerTitle='';
    @track isMaximized='Hide';
    @track size;
    
    searchValue = '';isSuggested=false;
    value = '';
 
    get options() {
        return [
            { label: '--None--', value: '' },
            { label: 'Opportunity Name', value: 'Name' },
            { label: 'Account Name', value: 'Account.Name' },
            { label: 'Amount', value: 'Amount' },
            { label: 'Type', value: 'Type' },
            { label: 'Stage Name', value: 'StageName' },
            { label: 'Close Date', value: 'CloseDate' }
        ];
    }
    handleChange(event) {
        this.value = event.detail.value;
        console.log(this.value);
        if(this.value == 'CloseDate'){
            this.isCloseDate = true;
        }else{
            this.isCloseDate = false; 
        } 
    }
    searchKeyword(event) {
        this.searchValue = event.target.value;
        console.log(this.searchValue);
        if(this.searchValue == '') this.isSuggested = false;
        setTimeout(() => {  this.suggestions() }, 800);    //if length >2 yet to implement
    }

    handleSearchKeyword() {
        this.allOpps = null;
        console.log('in search method!! '+this.searchValue);

        if(this.searchValue !== ''){
            this.showSpinner = true;
            this.spinnerTitle = "fetching for '"+this.searchValue+"'";
            this.size = "small";
            let timer = window.setTimeout(()=>{
                getOpportunity({
                    searchKey: this.searchValue,
                    filterKey: this.value
                })
                .then(result => {
                    this.OpportunityRecord = result;
                    console.log(JSON.stringify(this.OpportunityRecord));
                    var tempOppList = [];  
                    for (var i = 0; i < result.length; i++) {
                        let tempRecord = Object.assign({}, result[i]); //cloning object  
                        tempRecord.oppLink = "/" + tempRecord.Id;  
                        tempRecord.accLink = "/" + tempRecord.AccountId; 
                        if(tempRecord.Amount != null)
                            tempRecord.Amount = tempRecord.Amount.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
                        tempOppList.push(tempRecord);
                    }
                    console.log(this.OpportunityRecord[0].Amount);
                    //console.log(this.OpportunityRecord[0].Amount.toLocaleString('en-US', { style: 'currency', currency: 'USD' }));
                    //number.toLocaleString('en-US', { style: 'currency', currency: 'USD' })
                    this.OpportunityRecord = [];
                    this.OpportunityRecord = tempOppList;
                    //this.OpportunityRecord = Object.assign({}, tempOppList);
                    //console.log(JSON.stringify(tempOppList));
                    console.log(JSON.stringify(this.OpportunityRecord));

                    this.totalRecountCount = this.OpportunityRecord.length;
                    this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
                    this.firstChunk = this.OpportunityRecord.slice(0,this.pageSize); 
                    if(this.OpportunityRecord.length <= this.pageSize){
                        this.disablenextbutton = true;
                    }else{
                        this.disablenextbutton = false;
                    }
                    this.disablepreviousbutton = true;
                })
                .catch(error => {
                   
                    const event = new ShowToastEvent({
                        title: 'Error',
                        variant: 'error',
                        message: error.body.message,
                    });
                    this.dispatchEvent(event);
                    this.OpportunityRecord = null;
                    this.firstChunk = null;
                });
                this.showSpinner = false;
            window.clearTimeout(timer);
        },3000);
        }else{
            const event = new ShowToastEvent({
                variant: 'error',
                message: 'Search text missing..',
            });
            this.dispatchEvent(event);
            this.OpportunityRecord = null;
            this.firstChunk = null;
        }
         
    }

    suggestions(){
        if (this.searchValue !== '' && this.isSuggested==false ) {
        console.log(this.searchValue);
        opportunityDetails({searchHints:this.searchValue})
        .then(result=>{
            this.allOpps = result;
            console.log('all Opps'+JSON.stringify(this.allOpps));
            console.log('all Opps'+JSON.stringify(this.allOpps[0]));
        })
        .catch(error=>{
            this.error = error;
        })
    }else{
        this.allOpps=null;
    }
        
    }

    getSuggestionsValue(event){
        let optionValue = event.target.dataset.optionValue;
        this.searchValue = optionValue;
        this.allOpps=null;
        this.isSuggested = true;
        //document.getElementById("sugg").style.display = "none";
        console.log(' In Suggestions Option --> '+optionValue);
    }

    clearData(){
        //document.getElementById("searchText").value = "";
        let li = this.template.querySelector('lightning-input');
        let cb = this.template.querySelector('lightning-combobox');
        cb.value=null;
        li.value='';
        this.searchValue='';
        this.firstChunk = null;
        this.OpportunityRecord = null;
        this.isCloseDate = false;
        const CloseDateValue = this.cDate;
        const isCard = this.isCloseDate;
        const valueChangeEvent = new CustomEvent("valuechange", {
            detail: { CloseDateValue,isCard }
            });
        this.dispatchEvent(valueChangeEvent);  
    }
    handleClick() {
        this.isminimized = !this.isminimized;
        this.isMaximized = this.isMaximized=='Hide'?'Show':'Hide';
    }
    dateChange(event){
        this.cDate = event.target.value;
        this.showSpinner = true;
        this.spinnerTitle = "fetching opportunities closing on: "+this.cDate;
        this.size = "medium";
        let timer = window.setTimeout(()=>{
            const CloseDateValue = this.cDate;
            const isCard = this.isCloseDate;
            const valueChangeEvent = new CustomEvent("valuechange", {
                detail: { CloseDateValue,isCard }
                });
            this.dispatchEvent(valueChangeEvent);  
            this.showSpinner = false;
            window.clearTimeout(timer);
        },3000);  
    }

    initialized = false;
 
    renderedCallback() {
        // if (this.initialized) {
        //     return;
        // }
        // this.initialized = true;
        // let listId = this.template.querySelector('datalist').id;
        // this.template.querySelector("input").setAttribute("list", listId);
        // console.log("success?");
    }
    
}