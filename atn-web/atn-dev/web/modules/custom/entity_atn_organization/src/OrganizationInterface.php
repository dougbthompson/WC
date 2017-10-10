<?php

namespace Drupal\entity_atn_organization;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\organization\EntityOwnerInterface;
use Drupal\Core\Entity\EntityChangedInterface;

/**
 * Provides an interface defining a Organization entity.
 *
 * We have this interface so we can join the other interfaces it extends.
 *
 * @ingroup entity_atn_organization
 */
interface OrganizationInterface extends ContentEntityInterface, EntityOwnerInterface, EntityChangedInterface {

}
