import { LightningElement,track,api } from 'lwc';

export default class Paginator extends LightningElement {
    @api disablepreviousbutton ;
    @api disablenextbutton ;    
    previousHandler() {
        this.dispatchEvent(new CustomEvent('previous'));
    }

    nextHandler() {
        this.dispatchEvent(new CustomEvent('next'));
    }
}