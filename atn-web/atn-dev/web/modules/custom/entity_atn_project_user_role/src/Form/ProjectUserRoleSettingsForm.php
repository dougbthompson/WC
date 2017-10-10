<?php

namespace Drupal\entity_atn_project_user_role\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class ProjectUserRoleSettingsForm.
 *
 * @ingroup entity_atn_project_user_role
 */
class ProjectUserRoleSettingsForm extends FormBase {
  /**
   * Returns a unique string identifying the form.
   *
   * @return string
   *   The unique string identifying the form.
   */
  public function getFormId() {
    return 'entity_atn_project_user_role_settings';
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
    $form['project_user_role_settings']['#markup'] = 'Settings form for EntityATNProjectUserRole. Manage field settings here.';
    return $form;
  }

}
