<?php

namespace Drupal\entity_atn_orgz;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\user\EntityOwnerInterface;
use Drupal\Core\Entity\EntityChangedInterface;

/**
 * Provides an interface defining a Organization entity.
 *
 * We have this interface so we can join the other interfaces it extends.
 *
 * @ingroup entity_atn_orgz
 */
interface OrgzInterface extends ContentEntityInterface, EntityOwnerInterface, EntityChangedInterface {

}
