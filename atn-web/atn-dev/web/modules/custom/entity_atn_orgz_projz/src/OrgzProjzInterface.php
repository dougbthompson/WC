<?php

namespace Drupal\entity_atn_orgz_projz;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\user\EntityOwnerInterface;
use Drupal\Core\Entity\EntityChangedInterface;

/**
 * Provides an interface defining a Organization Project entity.
 *
 * We have this interface so we can join the other interfaces it extends.
 *
 * @ingroup entity_atn_orgz_projz
 */
interface OrgzProjzInterface extends ContentEntityInterface, EntityOwnerInterface, EntityChangedInterface {

}
