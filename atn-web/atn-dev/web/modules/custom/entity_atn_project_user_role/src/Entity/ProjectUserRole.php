<?php

namespace Drupal\entity_atn_project_user_role\Entity;

use Drupal\Core\Entity\EntityStorageInterface;
use Drupal\Core\Field\BaseFieldDefinition;
use Drupal\Core\Entity\ContentEntityBase;
use Drupal\Core\Entity\EntityTypeInterface;
use Drupal\entity_atn_project_user_role\ProjectUserRoleInterface;
use Drupal\project_user_role\ProjectUserRoleInterface;
use Drupal\Core\Entity\EntityChangedTrait;

/**
 * Defines the ContentEntityExample entity.
 *
 * @ingroup entity_atn_project_user_role
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
 *   id = "entity_atn_project_user_role_project_user_role",
 *   label = @Translation("ProjectUserRole entity"),
 *   handlers = {
 *     "view_builder" = "Drupal\Core\Entity\EntityViewBuilder",
 *     "list_builder" = "Drupal\entity_atn_project_user_role\Entity\Controller\ProjectUserRoleListBuilder",
 *     "form" = {
 *       "add" = "Drupal\entity_atn_project_user_role\Form\ProjectUserRoleForm",
 *       "edit" = "Drupal\entity_atn_project_user_role\Form\ProjectUserRoleForm",
 *       "delete" = "Drupal\entity_atn_project_user_role\Form\ProjectUserRoleDeleteForm",
 *     },
 *     "access" = "Drupal\entity_atn_project_user_role\ProjectUserRoleAccessControlHandler",
 *   },
 *   list_cache_contexts = { "project_user_role" },
 *   base_table = "atn_project_user_role",
 *   admin_permission = "administer entity_atn_project_user_role entity",
 *   entity_keys = {
 *     "id"    = "id",
 *     "label" = "project_user_role_name"
 *   },
 *   links = {
 *     "canonical" = "/entity_atn_project_user_role_project_user_role/{entity_atn_project_user_role_project_user_role}",
 *     "edit-form" = "/entity_atn_project_user_role_project_user_role/{entity_atn_project_user_role_project_user_role}/edit",
 *     "delete-form" = "/project_user_role/{entity_atn_project_user_role_project_user_role}/delete",
 *     "collection" = "/entity_atn_project_user_role_project_user_role/list"
 *   },
 *   field_ui_base_route = "entity_atn_project_user_role.project_user_role_settings",
 * )
 *
 * The 'links' above are defined by their path. For core to find the
 * corresponding route, the route name must follow the correct pattern:
 *
 * entity.<entity-name>.<link-name> (replace dashes with underscores)
 * Example: 'entity.entity_atn_project_user_role_project_user_role.canonical'
 *
 * See routing file above for the corresponding implementation
 *
 * The ProjectUserRole class defines methods and fields for the project_user_role entity.
 *
 * Being derived from the ContentEntityBase class, we can override the methods
 * we want. In our case we want to provide access to the standard fields about
 * creation and changed time stamps.
 *
 * Our interface (see ProjectUserRoleInterface) also exposes the EntityOwnerInterface.
 * This allows us to provide methods for setting and providing ownership
 * information.
 *
 * The most important part is the definitions of the field properties for this
 * entity type. These are of the same type as fields added through the GUI, but
 * they can by changed in code. In the definition we can define if the project_user_role with
 * the rights privileges can influence the presentation (view, edit) of each
 * field.
 *
 * The class also uses the EntityChangedTrait trait which allows it to record
 * timestamps of save operations.
 */
class ProjectUserRole extends ContentEntityBase implements ProjectUserRoleInterface {

  use EntityChangedTrait;

  /**
   * {@inheritdoc}
   *
   * When a new entity instance is added, set the project_user_role_id entity reference to
   * the current project_user_role as the creator of the instance.
   */
  public static function preCreate(EntityStorageInterface $storage_controller, array &$values) {
    parent::preCreate($storage_controller, $values);
    $values += [
      'project_user_role_id' => \Drupal::currentProjectUserRole()->id(),
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
    return $this->get('project_user_role_id')->entity;
  }

  /**
   * {@inheritdoc}
   */
  public function getOwnerId() {
    return $this->get('project_user_role_id')->target_id;
  }

  /**
   * {@inheritdoc}
   */
  public function setOwnerId($uid) {
    $this->set('project_user_role_id', $uid);
    return $this;
  }

  /**
   * {@inheritdoc}
   */
  public function setOwner(ProjectUserRoleInterface $account) {
    $this->set('project_user_role_id', $account->id());
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
      ->setDescription(t('The ID of the ProjectUserRole entity.'))
      ->setReadOnly(TRUE);

    $fields['org_project_id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('OrgProjectID'))
      ->setDescription(t('The Organization Project ID of the ProjectUserRole entity.'))
      ->setReadOnly(TRUE);

    $fields['user_role_id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('UserRoleID'))
      ->setDescription(t('The User Role ID of the ProjectUserRole entity.'))
      ->setReadOnly(TRUE);

    $fields['user_id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('UserID'))
      ->setDescription(t('The User ID of the ProjectUserRole entity.'))
      ->setReadOnly(TRUE);

    $fields['contact_id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('ContactID'))
      ->setDescription(t('The Contact ID of the ProjectUserRole entity.'))
      ->setReadOnly(TRUE);

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

