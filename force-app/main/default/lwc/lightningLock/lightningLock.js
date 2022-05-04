import { api, LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import isLocked from '@salesforce/apex/LightningLockHelper.isLocked';
import lock from '@salesforce/apex/LightningLockHelper.lock';
import unlock from '@salesforce/apex/LightningLockHelper.unlock';

export default class LightningLock extends LightningElement {
     
     @api recordId

     isLocked = false

     async renderedCallback() {
          this.isLocked = await isLocked({ recordId: this.recordId })
          
          if (!this.isLocked) {
               this.template.querySelector('.lock').classList.toggle('unlock')
          }
     }

     async useLock() {
          this.template.querySelector('.lock').classList.toggle('unlock')

          this.isLocked = this.isLocked ? await unlock({ recordId: this.recordId }) : await lock({ recordId: this.recordId })          
     
          this.dispatchEvent(
               new ShowToastEvent({
                    title: 'Success',
                    message: `Record ${this.isLocked ? 'Locked 🔒' : 'Unlocked 🔓'}`,
                    variant: 'success'
               })
          )
     }
}