<?php

namespace Drupal\entity_atn_project_user_role\Form;

use Drupal\Core\Entity\ContentEntityForm;
use Drupal\Core\Language\Language;
use Drupal\Core\Form\FormStateInterface;

/**
 * Form controller for the entity_atn_project_user_role entity edit forms.
 *
 * @ingroup entity_atn_project_user_role
 */
class ProjectUserRoleForm extends ContentEntityForm {

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    /* @var $entity \Drupal\entity_atn_project_user_role\Entity\ProjectUserRole */
    $form = parent::buildForm($form, $form_state);
    $entity = $this->entity;

    $form['langcode'] = [
      '#title' => $this->t('Language'),
      '#type' => 'language_select',
      '#default_value' => $entity->getUntranslated()->language()->getId(),
      '#languages' => Language::STATE_ALL,
    ];
    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function save(array $form, FormStateInterface $form_state) {
    $form_state->setRedirect('entity.entity_atn_project_user_role_project_user_role.collection');
    $entity = $this->getEntity();
    $entity->save();
  }

}
