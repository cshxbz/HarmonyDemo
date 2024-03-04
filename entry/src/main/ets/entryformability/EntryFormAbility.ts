import formInfo from '@ohos.app.form.formInfo';
import formBindingData from '@ohos.app.form.formBindingData';
import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';
import { logUtil } from 'app_base_lib'
import Prompt from '@system.prompt';
import promptAction from '@ohos.promptAction';

export default class EntryFormAbility extends FormExtensionAbility {
  private readonly logTag: string = "EntryFormAbility"

  onAddForm(want) {
    logUtil.i(this.logTag, 'onAddForm')
    let formData = {};
    return formBindingData.createFormBindingData(formData);
  }

  onCastToNormalForm(formId) {
    logUtil.i(this.logTag, 'onCastToNormalForm')
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
  }

  onUpdateForm(formId) {
    logUtil.i(this.logTag, 'onUpdateForm')
    // Called to notify the form provider to update a specified form.
  }

  onChangeFormVisibility(newStatus) {
    logUtil.i(this.logTag, 'onChangeFormVisibility')
    // Called when the form provider receives form events from the system.
  }

  onFormEvent(formId, message) {
    logUtil.i(this.logTag, `onFormEvent -- formId: ${formId}  message: ${message}`)
  }

  onRemoveForm(formId) {
    logUtil.i(this.logTag, 'onRemoveForm')
    // Called to notify the form provider that a specified form has been destroyed.
  }

  onAcquireFormState(want) {
    logUtil.i(this.logTag, 'onAcquireFormState')
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }
};