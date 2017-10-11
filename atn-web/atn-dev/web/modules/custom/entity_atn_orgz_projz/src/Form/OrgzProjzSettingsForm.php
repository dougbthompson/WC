<?php

namespace Drupal\entity_atn_orgz_projz\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class OrgzProjzSettingsForm.
 *
 * @ingroup entity_atn_orgz_projz
 */
class OrgzProjzSettingsForm extends FormBase {
  /**
   * Returns a unique string identifying the form.
   *
   * @return string
   *   The unique string identifying the form.
   */
  public function getFormId() {
    return 'entity_atn_orgz_projz_settings';
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
    $form['orgz_projz_settings']['#markup'] = 'Settings form for Organization Project. Manage field settings here.';
    return $form;
  }

}
