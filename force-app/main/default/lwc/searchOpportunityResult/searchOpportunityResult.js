import { LightningElement,api,track } from 'lwc';

export default class SearchOpportunityResult extends LightningElement {
    value = '';
    @track disablepreviousbutton ;
    @api disablenextbutton ;
    @track page=1;
    @track pageSize=5;
    @track startingRecord = 1; 
    @track endingRecord = 0;
    @api allopportunities;
    @api targetid='';
    @api totalrecountcount = 0; 
    @api totalpage = 0; 
    @api firstdata;
    
    get options() {
        return [
            { label: '5', value: '5' },
            { label: '10', value: '10' },
            { label: '15', value: '15' },
            { label: '20', value: '20' },
            { label: '25', value: '25' },
            { label: '30', value: '30' }
        ];
    }

    constructor(){
        super();
        this.disablepreviousbutton = true;
        this.targetid='';
    }
    handleChange(event) {
        this.value = event.detail.value;
        console.log(this.value);
        this.pageSize = parseInt(this.value);
        this.page = 1;
        this.firstdata = this.allopportunities.slice(0,this.pageSize);
        console.log('-->'+this.firstdata);
        console.log(this.page +'  '+this.totalpage); 
        console.log('totalrecord '+this.allopportunities.length);
        console.log('pagesize '+this.pageSize);
        this.totalpage = Math.ceil(this.allopportunities.length / this.pageSize);
        console.log(this.page +'  '+this.totalpage);
        this.disablepreviousbutton = true;
        if(this.allopportunities.length <= this.pageSize){
            this.disablenextbutton = true;
        }else{
            this.disablenextbutton = false;
        }
        
    }
   
    previousHandler() {
        console.log('in pn');
        if (this.page > 1) {
            this.disablenextbutton = false;
            console.log(this.disablepreviousbutton);
            this.page = this.page - 1; //decrease page by 1
            if(this.page == 1)
                this.disablepreviousbutton = true;
            this.displayRecordPerPage(this.page);
        }
    }

    nextHandler() {
        console.log('in pn');
        
        if((this.page<this.totalpage) && this.page !== this.totalpage){
            this.disablepreviousbutton = false;
            console.log(this.disablepreviousbutton);
            this.page = this.page + 1; //increase page by 1
            if(this.page == this.totalpage)
                this.disablenextbutton = true;
            this.displayRecordPerPage(this.page);            
        }             
    }

    displayRecordPerPage(page){
        console.log('in pn');
        this.startingRecord = ((page -1) * this.pageSize) ;
        this.endingRecord = (page * this.pageSize );

        this.endingRecord = (this.endingRecord > this.totalrecountcount) 
                            ? this.totalrecountcount : this.endingRecord; 

        this.firstdata = this.allopportunities.slice(this.startingRecord, this.endingRecord);

        this.startingRecord = this.startingRecord + 1;
    }

    sendMail(event){
        this.targetid = event.target.dataset.id;
        console.log(this.targetid);
    }
    
}