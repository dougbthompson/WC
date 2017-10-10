<?php

namespace Drupal\entity_atn_organization_project\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class OrganizationProjectSettingsForm.
 *
 * @ingroup entity_atn_organization_project
 */
class OrganizationProjectSettingsForm extends FormBase {
  /**
   * Returns a unique string identifying the form.
   *
   * @return string
   *   The unique string identifying the form.
   */
  public function getFormId() {
    return 'entity_atn_organization_project_settings';
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
    $form['organization_project_settings']['#markup'] = 'Settings form for EntityATNOrganizationProject. Manage field settings here.';
    return $form;
  }

}
