<?php

namespace Drupal\entity_atn_user;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\user\EntityOwnerInterface;
use Drupal\Core\Entity\EntityChangedInterface;

/**
 * Provides an interface defining a User entity.
 *
 * We have this interface so we can join the other interfaces it extends.
 *
 * @ingroup entity_atn_user
 */
interface UsersInterface extends ContentEntityInterface, EntityOwnerInterface, EntityChangedInterface {

}
