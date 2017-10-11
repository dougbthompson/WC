<?php

namespace Drupal\entity_atn_projz_ur\Entity\Controller;

use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Entity\EntityTypeInterface;
use Drupal\Core\Entity\EntityListBuilder;
use Drupal\Core\Entity\EntityStorageInterface;
use Drupal\Core\Routing\UrlGeneratorInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Provides a list controller for entity_atn_projz_ur entity.
 *
 * @ingroup entity_atn_projz_ur
 */
class ProjzURListBuilder extends EntityListBuilder {

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
   * Constructs a new ProjzURListBuilder object.
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
      '#markup' => $this->t('These projects are fieldable entities. You can manage the fields on the <a href="@adminlink">Project User Role admin page</a>.', [
        '@adminlink' => $this->urlGenerator->generateFromRoute('entity_atn_projz_ur.projz_ur_settings'),
      ]),
    ];
    $build['table'] = parent::render();
    return $build;
  }

  /**
   * {@inheritdoc}
   *
   * Building the header and content lines for the project list.
   *
   * Calling the parent::buildHeader() adds a column for the possible actions
   * and inserts the 'edit' and 'delete' links as defined for the entity type.
   */
  public function buildHeader() {
    $header['id']             = $this->t('ID');
    $header['org_project_id'] = $this->t('Org Project ID');
    $header['user_role_id']   = $this->t('User Role ID');
    $header['user_id']        = $this->t('User ID');
    $header['contact_id']     = $this->t('Contact ID');
    return $header + parent::buildHeader();
  }

  /**
   * {@inheritdoc}
   */
  public function buildRow(EntityInterface $entity) {
    /* @var $entity \Drupal\entity_atn_projz_ur\Entity\ProjzUR */
    $row['id']             = $entity->id();
    $row['org_project_id'] = $entity->org_project_id->value;
    $row['user_role_id']   = $entity->user_role_id->value;
    $row['user_id']        = $entity->user_id->value;
    $row['contact_id']     = $entity->contact_id->value;
    return $row + parent::buildRow($entity);
  }

}

