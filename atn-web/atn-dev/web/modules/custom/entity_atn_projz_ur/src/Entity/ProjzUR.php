<?php

namespace Drupal\entity_atn_projz_ur\Entity;

use Drupal\Core\Entity\EntityStorageInterface;
use Drupal\Core\Field\BaseFieldDefinition;
use Drupal\Core\Entity\ContentEntityBase;
use Drupal\Core\Entity\EntityTypeInterface;
use Drupal\entity_atn_projz_ur\ProjzURInterface;
use Drupal\user\UserInterface;
use Drupal\Core\Entity\EntityChangedTrait;

/**
 * Defines the ContentEntityExample entity.
 *
 * @ingroup entity_atn_projz_ur
 *
 * This is the main definition of the entity type. From it, an entityType is
 * derived. The most important properties in this example are listed below.
 *
 * id: The unique identifier of this entityType. It follows the pattern
 * 'moduleName_xyz' to avoid naming conflicts.
 *
 * label: Human readable name of the entity type.
 *
 * handlers: Handler classes are used for different tasks. You can use
 * standard handlers provided by D8 or build your own, most probably derived
 * from the standard class. In detail:
 *
 * - view_builder: we use the standard controller to view an instance. It is
 *   called when a route lists an '_entity_view' default for the entityType
 *   (see routing.yml for details. The view can be manipulated by using the
 *   standard drupal tools in the settings.
 *
 * - list_builder: We derive our own list builder class from the
 *   entityListBuilder to control the presentation.
 *   If there is a view available for this entity from the views module, it
 *   overrides the list builder. @todo: any view? naming convention?
 *
 * - form: We derive our own forms to add functionality like additional fields,
 *   redirects etc. These forms are called when the routing list an
 *   '_entity_form' default for the entityType. Depending on the suffix
 *   (.add/.edit/.delete) in the route, the correct form is called.
 *
 * - access: Our own accessController where we determine access rights based on
 *   permissions.
 *
 * More properties:
 *
 *  - base_table: Define the name of the table used to store the data. Make sure
 *    it is unique. The schema is automatically determined from the
 *    BaseFieldDefinitions below. The table is automatically created during
 *    installation.
 *
 *  - fieldable: Can additional fields be added to the entity via the GUI?
 *    Analog to content types.
 *
 *  - entity_keys: How to access the fields. Analog to 'nid' or 'uid'.
 *
 *  - links: Provide links to do standard tasks. The 'edit-form' and
 *    'delete-form' links are added to the list built by the
 *    entityListController. They will show up as action buttons in an additional
 *    column.
 *
 * There are many more properties to be used in an entity type definition. For
 * a complete overview, please refer to the '\Drupal\Core\Entity\EntityType'
 * class definition.
 *
 * The following construct is the actual definition of the entity type which
 * is read and cached. Don't forget to clear cache after changes.
 *
 * @ContentEntityType(
 *   id = "entity_atn_projz_ur_projz_ur",
 *   label = @Translation("Product User Role entity"),
 *   handlers = {
 *     "view_builder" = "Drupal\Core\Entity\EntityViewBuilder",
 *     "list_builder" = "Drupal\entity_atn_projz_ur\Entity\Controller\ProjzURListBuilder",
 *     "form" = {
 *       "add" = "Drupal\entity_atn_projz_ur\Form\ProjzURForm",
 *       "edit" = "Drupal\entity_atn_projz_ur\Form\ProjzURForm",
 *       "delete" = "Drupal\entity_atn_projz_ur\Form\ProjzURDeleteForm",
 *     },
 *     "access" = "Drupal\entity_atn_projz_ur\ProjzURAccessControlHandler",
 *   },
 *   list_cache_contexts = { "project user role" },
 *   base_table = "atn_project_user_role",
 *   admin_permission = "administer entity_atn_projz_ur entity",
 *   entity_keys = {
 *     "id"    = "id",
 *     "label" = "project_user_role_name"
 *   },
 *   links = {
 *     "canonical" = "/entity_atn_projz_ur_projz_ur/{entity_atn_projz_ur_projz_ur}",
 *     "edit-form" = "/entity_atn_projz_ur_projz_ur/{entity_atn_projz_ur_projz_ur}/edit",
 *     "delete-form" = "/projz_ur/{entity_atn_projz_ur_projz_ur}/delete",
 *     "collection" = "/entity_atn_projz_ur_projz_ur/list"
 *   },
 *   field_ui_base_route = "entity_atn_projz_ur.projz_ur_settings",
 * )
 *
 * The 'links' above are defined by their path. For core to find the
 * corresponding route, the route name must follow the correct pattern:
 *
 * entity.<entity-name>.<link-name> (replace dashes with underscores)
 * Example: 'entity.entity_atn_projz_ur_projz_ur.canonical'
 *
 * See routing file above for the corresponding implementation
 *
 * The ProjzUR class defines methods and fields for the project entity.
 *
 * Being derived from the ContentEntityBase class, we can override the methods
 * we want. In our case we want to provide access to the standard fields about
 * creation and changed time stamps.
 *
 * Our interface (see ProjzURInterface) also exposes the EntityOwnerInterface.
 * This allows us to provide methods for setting and providing ownership
 * information.
 *
 * The most important part is the definitions of the field properties for this
 * entity type. These are of the same type as fields added through the GUI, but
 * they can by changed in code. In the definition we can define if the project
 * with the rights privileges can influence the presentation (view, edit) of each
 * field.
 *
 * The class also uses the EntityChangedTrait trait which allows it to record
 * timestamps of save operations.
 */
class ProjzUR extends ContentEntityBase implements ProjzURInterface {

  use EntityChangedTrait;

  /**
   * {@inheritdoc}
   *
   * When a new entity instance is added, set the projz_ur_id entity reference to
   * the current project as the creator of the instance.
   */
  public static function preCreate(EntityStorageInterface $storage_controller, array &$values) {
    parent::preCreate($storage_controller, $values);
    $values += [
      'projz_ur_id' => \Drupal::currentProjzUR()->id(),
    ];
  }

  /**
   * {@inheritdoc}
   */
  public function getCreatedTime() {
    return $this->get('created')->value;
  }

  /**
   * {@inheritdoc}
   */
  public function getChangedTime() {
    return $this->get('changed')->value;
  }

  /**
   * {@inheritdoc}
   */
  public function getOwner() {
    return $this->get('projz_ur_id')->entity;
  }

  /**
   * {@inheritdoc}
   */
  public function getOwnerId() {
    return $this->get('projz_ur_id')->target_id;
  }

  /**
   * {@inheritdoc}
   */
  public function setOwnerId($uid) {
    $this->set('projz_ur_id', $uid);
    return $this;
  }

  /**
   * {@inheritdoc}
   */
  public function setOwner(UserInterface $account) {
    $this->set('projz_ur_id', $account->id());
    return $this;
  }

  /**
   * {@inheritdoc}
   *
   * Define the field properties here.
   *
   * Field name, type and size determine the table structure.
   *
   * In addition, we can define how the field and its content can be manipulated
   * in the GUI. The behaviour of the widgets used can be determined here.
   */
  public static function baseFieldDefinitions(EntityTypeInterface $entity_type) {

    // Standard field, used as unique if primary index.
    $fields['id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('ID'))
      ->setDescription(t('The ID of the Project User Role entity.'))
      ->setReadOnly(TRUE);

    $fields['org_project_id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('Org Project ID'))
      ->setDescription(t('The Organization Project ID of the Project User Role entity.'))
      ->setReadOnly(FALSE);

    $fields['user_role_id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('User Role ID'))
      ->setDescription(t('The User Role ID of the Project User Role entity.'))
      ->setReadOnly(FALSE);

    $fields['user_id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('User ID'))
      ->setDescription(t('The User ID of the Project User Role entity.'))
      ->setReadOnly(FALSE);

    $fields['contact_id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('Contact ID'))
      ->setDescription(t('The Contact ID of the Project User Role entity.'))
      ->setReadOnly(FALSE);

    $fields['langcode'] = BaseFieldDefinition::create('language')
      ->setLabel(t('Language code'))
      ->setDescription(t('The language code of ContentEntityExample entity.'));

    $fields['created'] = BaseFieldDefinition::create('created')
      ->setLabel(t('Created'))
      ->setDescription(t('The time that the entity was created.'));

    $fields['changed'] = BaseFieldDefinition::create('changed')
      ->setLabel(t('Changed'))
      ->setDescription(t('The time that the entity was last edited.'));

    return $fields;
  }

}

