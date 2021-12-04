import { LightningElement,api,track } from 'lwc';

export default class LightningLoader extends LightningElement {
    @api text;
    @api size = 'medium';

    get helpText(){
        return this.text?this.text : 'Loading....';
    }

}