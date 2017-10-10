<?php

namespace Drupal\entity_atn_user_role\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class UserRoleSettingsForm.
 *
 * @ingroup entity_atn_user_role
 */
class UserRoleSettingsForm extends FormBase {
  /**
   * Returns a unique string identifying the form.
   *
   * @return string
   *   The unique string identifying the form.
   */
  public function getFormId() {
    return 'entity_atn_user_role_settings';
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    // Empty implementation of the abstract submit class.
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    $form['user_role_settings']['#markup'] = 'Settings form for EntityATNUserRole. Manage field settings here.';
    return $form;
  }

}
