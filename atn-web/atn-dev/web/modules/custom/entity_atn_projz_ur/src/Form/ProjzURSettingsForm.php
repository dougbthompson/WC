<?php

namespace Drupal\entity_atn_projz_ur\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class ProjzURSettingsForm.
 *
 * @ingroup entity_atn_projz_ur
 */
class ProjzURSettingsForm extends FormBase {
  /**
   * Returns a unique string identifying the form.
   *
   * @return string
   *   The unique string identifying the form.
   */
  public function getFormId() {
    return 'entity_atn_projz_ur_settings';
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
    $form['projz_ur_settings']['#markup'] = 'Settings form for Project User Role. Manage field settings here.';
    return $form;
  }

}
