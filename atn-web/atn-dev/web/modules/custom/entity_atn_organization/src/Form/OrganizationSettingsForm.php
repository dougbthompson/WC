<?php

namespace Drupal\entity_atn_organization\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class OrganizationSettingsForm.
 *
 * @ingroup entity_atn_organization
 */
class OrganizationSettingsForm extends FormBase {
  /**
   * Returns a unique string identifying the form.
   *
   * @return string
   *   The unique string identifying the form.
   */
  public function getFormId() {
    return 'entity_atn_organization_settings';
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
    $form['organization_settings']['#markup'] = 'Settings form for EntityATNOrganization. Manage field settings here.';
    return $form;
  }

}
