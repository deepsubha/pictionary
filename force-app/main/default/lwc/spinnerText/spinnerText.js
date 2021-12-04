import { LightningElement, track } from 'lwc';

export default class SpinnerText extends LightningElement {
    @track showSpinner=false;

    spinnerOneHandler(event){
        // const{name} = event.target;
        // this[name] = true;

        this.showSpinner = true;

        let timer = window.setTimeout(()=>{
            //this[name] = false;
            this.showSpinner = false;
            window.clearTimeout(timer);
        },3000);
        
    }

}