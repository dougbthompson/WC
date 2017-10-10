<?php

namespace Drupal\entity_atn_project_user_role;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\project_user_role\EntityOwnerInterface;
use Drupal\Core\Entity\EntityChangedInterface;

/**
 * Provides an interface defining a ProjectUserRole entity.
 *
 * We have this interface so we can join the other interfaces it extends.
 *
 * @ingroup entity_atn_project_user_role
 */
interface ProjectUserRoleInterface extends ContentEntityInterface, EntityOwnerInterface, EntityChangedInterface {

}
