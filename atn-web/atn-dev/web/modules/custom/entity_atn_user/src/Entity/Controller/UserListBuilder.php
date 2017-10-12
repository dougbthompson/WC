<?php

namespace Drupal\entity_atn_user\Entity\Controller;

use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Entity\EntityTypeInterface;
use Drupal\Core\Entity\EntityListBuilder;
use Drupal\Core\Entity\EntityStorageInterface;
use Drupal\Core\Routing\UrlGeneratorInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Provides a list controller for entity_atn_user entity.
 *
 * @ingroup entity_atn_user
 */
class UserListBuilder extends EntityListBuilder {

  /**
   * The url generator.
   *
   * @var \Drupal\Core\Routing\UrlGeneratorInterface
   */
  protected $urlGenerator;

  /**
   * {@inheritdoc}
   */
  public static function createInstance(ContainerInterface $container, EntityTypeInterface $entity_type) {
    return new static(
      $entity_type,
      $container->get('entity.manager')->getStorage($entity_type->id()),
      $container->get('url_generator')
    );
  }

  /**
   * Constructs a new UserListBuilder object.
   *
   * @param \Drupal\Core\Entity\EntityTypeInterface $entity_type
   *   The entity type definition.
   * @param \Drupal\Core\Entity\EntityStorageInterface $storage
   *   The entity storage class.
   * @param \Drupal\Core\Routing\UrlGeneratorInterface $url_generator
   *   The url generator.
   */
  public function __construct(EntityTypeInterface $entity_type, EntityStorageInterface $storage, UrlGeneratorInterface $url_generator) {
    parent::__construct($entity_type, $storage);
    $this->urlGenerator = $url_generator;
  }

  /**
   * {@inheritdoc}
   *
   * We override ::render() so that we can add our own content above the table.
   * parent::render() is where EntityListBuilder creates the table using our
   * buildHeader() and buildRow() implementations.
   */
  public function render() {
    $build['description'] = [
      '#markup' => $this->t('These users are fieldable entities. You can manage the fields on the <a href="@adminlink">User admin page</a>.', [
        '@adminlink' => $this->urlGenerator->generateFromRoute('entity_atn_user.user_settings'),
      ]),
    ];
    $build['table'] = parent::render();
    return $build;
  }

  /**
   * {@inheritdoc}
   *
   * Building the header and content lines for the user list.
   *
   * Calling the parent::buildHeader() adds a column for the possible actions
   * and inserts the 'edit' and 'delete' links as defined for the entity type.
   */
  public function buildHeader() {
    $header['id']               = $this->t('User ID');
    $header['user_name']        = $this->t('User Name');
    $header['user_password']    = $this->t('User Password');
    $header['title']            = $this->t('Title');
    $header['address1']         = $this->t('Address1');
    $header['address2']         = $this->t('Address2');
    $header['address3']         = $this->t('Address3');
    $header['email']            = $this->t('Email');
    $header['phone']            = $this->t('Phone');
    $header['user_directory']   = $this->t('User Directory');
    $header['auth_code']        = $this->t('Auth Code');
    $header['auth_status']      = $this->t('Auth Status');
    $header['citation']         = $this->t('Citation');
    $header['registered_date']  = $this->t('Registered Date');
    $header['last_update_date'] = $this->t('Last Update Date');
    return $header + parent::buildHeader();
  }

  /**
   * {@inheritdoc}
   */
  public function buildRow(EntityInterface $entity) {
    /* @var $entity \Drupal\entity_atn_user\Entity\User */
    $row['id']               = $entity->id();
    $row['user_name']        = $entity->user_name->value;
    $row['user_password']    = $entity->user_password->value;
    $row['title']            = $entity->title->value;
    $row['address1']         = $entity->address1->value;
    $row['address2']         = $entity->address1->value;
    $row['address3']         = $entity->address1->value;
    $row['email']            = $entity->email->value;
    $row['phone']            = $entity->phone->value;
    $row['user_directory']   = $entity->user_directory->value;
    $row['auth_code']        = $entity->auth_code->value;
    $row['auth_status']      = $entity->auth_status->value;
    $row['citation']         = $entity->citation->value;
    $row['registered_date']  = $entity->registered_date->value;
    $row['last_update_date'] = $entity->->st_update_datevalue;
    return $row + parent::buildRow($entity);
  }
}

