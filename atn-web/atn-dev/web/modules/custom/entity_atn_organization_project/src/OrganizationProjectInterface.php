<?php

namespace Drupal\entity_atn_organization_project;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\organization_project\EntityOwnerInterface;
use Drupal\Core\Entity\EntityChangedInterface;

/**
 * Provides an interface defining a OrganizationProject entity.
 *
 * We have this interface so we can join the other interfaces it extends.
 *
 * @ingroup entity_atn_organization_project
 */
interface OrganizationProjectInterface extends ContentEntityInterface, EntityOwnerInterface, EntityChangedInterface {

}
