import { LightningElement } from 'lwc';
import {mainMachine} from './sampleMachine';
import XState from '@salesforce/resourceUrl/XState';

export default class CounterMachine extends LightningElement {

    context = '';
    service = null;
    connectedCallback(){
        const {interpret} = XState;
        this.service = interpret(mainMachine());
        // this.service.start();
        // this.context = this.service.state.context;
        // console.log('context vars@@'+this.context);
    }
}