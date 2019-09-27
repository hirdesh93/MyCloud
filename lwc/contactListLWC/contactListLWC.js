// apexWireMethodToProperty.js
import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactControllerNewWithLWC.getContactList';

export default class ApexWireMethodToProperty extends LightningElement {
    @wire(getContactList) contacts;
}